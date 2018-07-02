//
//  AsynchronousOperation.swift
//  RAVAnimator
//
//  Created by Andrew Romanov on 02/07/2018.
//


//Taked from https://gist.github.com/Sorix/57bc3295dc001434fe08acbb053ed2bc
//created by Vasily Ulianov on 09.02.17
import Foundation

/// Subclass of `Operation` that add support of asynchronous operations.
/// ## How to use:
/// 1. Call `super.main()` when override `main` method, call `super.start()` when override `start` method.
/// 2. When operation is finished or cancelled set `self.state = .finished`
@objc open class AsynchronousOperation: Operation {
	override open var isAsynchronous: Bool { return true }
	override open var isExecuting: Bool { return state == .executing }
	override open var isFinished: Bool { return state == .finished }
	
	internal var state = State.ready {
		willSet {
			willChangeValue(forKey: state.keyPath)
			willChangeValue(forKey: newValue.keyPath)
		}
		didSet {
			didChangeValue(forKey: state.keyPath)
			didChangeValue(forKey: oldValue.keyPath)
		}
	}
	
	internal enum State: String {
		case ready = "Ready"
		case executing = "Executing"
		case finished = "Finished"
		fileprivate var keyPath: String { return "is" + self.rawValue }
	}
	
	override open func start() {
		if self.isCancelled {
			state = .finished
		} else {
			state = .ready
			main()
		}
	}
	
	override open func main() {
		if self.isCancelled {
			state = .finished
		} else {
			state = .executing
		}
	}
}
