//
//  Animation.swift
//  RAVAnimator
//
//  Created by Andrew Romanov on 01/07/2018.
//

import Foundation

@objc open class Animation: NSObject {

	internal var startTime : TimeInterval?
	
	@objc public var duration : TimeInterval
	@objc public var callWithZero = false
	
	@objc public init(withDuration duration: TimeInterval) {
		self.duration = duration
		super.init()
	}
	
	@objc open func update(withTime time: TimeInterval) {
		
	}
}
