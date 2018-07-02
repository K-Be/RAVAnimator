//
//  LinearValuesConverter.swift
//  RAVAnimator
//
//  Created by Andrew Romanov on 02/07/2018.
//

import Foundation


@objc public class LinearValuesConverter: NSObject, ValuesConverterP {
	
	public typealias TypeDestination = Double
	public typealias TypeSource = Double
	
	@objc public var sourceMin = 0.0
	@objc public var sourceMax = 1.0
	@objc public var destinationMin = 0.0
	@objc public var destinationMax = 1.0
	
	@objc public func convertSourceToDestination(source: TypeSource) -> TypeDestination
	{
		guard sourceMin != sourceMax && destinationMin != destinationMax else {
			assert(false, "must not be equal borders")
			return destinationMin;
		}
		
		let result = ((source - sourceMin) / (sourceMax - sourceMin)) * (destinationMax - destinationMin) + destinationMin
		return result
	}
	
	
	@objc public func convertDestiantionToSource(destination: TypeDestination) -> TypeSource
	{
		guard sourceMin != sourceMax && destinationMin != destinationMax else {
			assert(false, "must not be equal borders")
			return destinationMin;
		}
		
		let result = ((destination - destinationMin) / (destinationMax - destinationMin)) * (sourceMax - sourceMin) + sourceMin		
		return result
	}
}



