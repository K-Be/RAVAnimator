//
//  AnimationOperation.swift
//  RAVAnimator
//
//  Created by Andrew Romanov on 02/07/2018.
//

import UIKit

@objc open class AnimationOperation: AsynchronousOperation {
	
	var animation : Animation
	var animator : Animator
	
	@objc public init(withAnimation animation: Animation, forAnimator animator: Animator){
		self.animation = animation
		self.animator = animator

		super.init()
	}
	
	override open func main() {
		super.main()
		guard !self.isCancelled else {
			return
		}
		
		self.animation.complition = {
			self.state = .finished
		}
		QueueExecutor.execSyncOnMainThread {
			self.animator.add(animation: animation)
		}
	}
	
	
	open override func cancel() {
		if self.state == .executing {
			QueueExecutor.execSyncOnMainThread {
				self.animator.cancel(animation: self.animation)
			}
		}
		
		super.cancel()
	}
}
