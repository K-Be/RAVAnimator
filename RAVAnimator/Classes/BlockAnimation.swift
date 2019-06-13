//
//  BlockAnimation.swift
//  RAVAnimator
//
//  Created by Andrew Romanov on 02/07/2018.
//

import UIKit

@objc open class BlockAnimation: Animation {

	public typealias AnimationBlock = ((TimeInterval) -> Void)
	
	var animation : AnimationBlock
	
	@objc public init(withDuration duration: TimeInterval, animationBlock: @escaping AnimationBlock) {
		animation = animationBlock
		super.init(withDuration: duration)
	}
	
	open override func update(withTime time: TimeInterval) {
		super.update(withTime: time)
		self.animation(time)
	}
}
