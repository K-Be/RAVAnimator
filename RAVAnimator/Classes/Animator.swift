//
//  Animator.swift
//  RAVAnimator
//
//  Created by Andrew Romanov on 01/07/2018.
//

import Foundation
import QuartzCore


@objc open class Animator : NSObject {
	
	typealias AnimationsArray = Array<Animation>
	var animations = AnimationsArray()
	weak var displayLink : CADisplayLink?
	
	@objc public override init(){
		super.init()
	}
	
	@objc open func add(animation:Animation) {
		self.checkMainThread()
		assert(self.animations.index(of: animation) == nil, "tries twice add one animation");
		
		if (displayLink == nil)
		{
			let link = CADisplayLink(target: self, selector: #selector(updateAction(sender:)));
			link.add(to: RunLoop.main, forMode: .commonModes);
			
			self.displayLink = link
		}
		animation.startTime = self.currentTime()
		if (animation.callWithZero)
		{
			animation.update(withTime: TimeInterval(0.0))
		}
		self.animations.append(animation)
	}

	@objc open func cancel(animation: Animation) {
		self.checkMainThread()
		
		if let index = self.index(of: animation){
			animations.remove(at: index)
			
			self.invalidateIfNoAnimations()
		}
	}
	
	
	func index(of animation: Animation) -> AnimationsArray.Index? {
		let index = animations.index(of: animation)
		return index
	}
	
	func invalidateIfNoAnimations() {
		if (self.animations.count == 0)
		{
			if let link = self.displayLink {
				link.invalidate()
			}
			
			self.displayLink = nil
		}
	}
	
	@objc func updateAction(sender: CADisplayLink) {
		let currentTime = self.currentTime()
		
		var animationsToRemove = AnimationsArray()
		
		self.animations.forEach { (animation) in
			guard let startTime = animation.startTime else {
				return
			}
			
			let time = currentTime - startTime
			if (time >= animation.duration)
			{
				animationsToRemove.append(animation)
			}
			let corrected = min(animation.duration, time)
			
			self.willCallUpdate(for: animation, atTime: corrected)
			animation.update(withTime: corrected)
			self.didCallUpdate(for: animation, atTime: corrected)
		}
		
		animationsToRemove.forEach { (animation) in
		 	let removedAnimation = self.animations.removeIdentity(object: animation)
			assert(removedAnimation != nil, "can't find animation in the animations array")
		}
	}
	
	
	@objc open func willCallUpdate(for animation: Animation,atTime time: TimeInterval){
		
	}
	
	@objc open func didCallUpdate(for animation: Animation, atTime time: TimeInterval) {
		
	}
	
	func checkMainThread() {
		assert(Thread.isMainThread, "must be called only on the main thread")
	}
	
	func currentTime() -> TimeInterval {
		let time = Date().timeIntervalSince1970
		return time
	}
}
