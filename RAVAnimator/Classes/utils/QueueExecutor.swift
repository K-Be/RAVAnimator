//
//  QueueExecutor.swift
//  RAVAnimator
//
//  Created by Andrew Romanov on 02/07/2018.
//

import Foundation


public class QueueExecutor {
	
	public static func execSyncOnMainThread(block: ()->Void) {
		
		if Thread.isMainThread{
			block()
		}
		else {
			DispatchQueue.main.sync(execute: block)
		}
		
	}
	
	
	public static func execImmidiateOnMainThread(block: @escaping () -> Void) {
		if Thread.isMainThread{
			block()
		}
		else {
			DispatchQueue.main.async(execute: block)
		}
	}
	
}


