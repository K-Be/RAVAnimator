//
//  Array+ObjectsOperations.swift
//  RAVAnimator
//
//  Created by Andrew Romanov on 01/07/2018.
//

import Foundation


extension Array where Element : Equatable {
	internal mutating func remove(object: Element) -> Element?{
		guard let index = self.index(of: object) else {
			return nil
		}
		
		let elem = self[index]
		self.remove(at: index);
		return elem
	}
}


extension Array where Element : AnyObject {
	internal mutating func removeIdentity(object: Element) -> Element? {
		guard let index = self.index(where: {$0 === object}) else {
			return nil
		}
		
		let elem = self[index];
		self.remove(at: index)
		return elem
	}
}
