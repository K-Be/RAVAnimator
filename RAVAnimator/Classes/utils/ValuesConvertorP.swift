//
//  ValuesConvertorP.swift
//  RAVAnimator
//
//  Created by Andrew Romanov on 02/07/2018.
//

import Foundation


public protocol ValuesConvertorP {
	
	associatedtype TypeDestination
	associatedtype TypeSource
	
	func convertSourceToDestination(source: TypeSource) -> TypeDestination;
	func convertDestiantionToSource(destination: TypeDestination) -> TypeSource;
}
