//
//  PointsConverter.swift
//  RAVAnimator_Example
//
//  Created by Andrew Romanov on 02/07/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import CoreGraphics
import RAVAnimator


public class PointsConverter: ValuesConverterP {
	public	typealias TypeSource = Double
	public	typealias TypeDestination = CGPoint
	
	public var sourceMin = 0.0
	public var sourceMax = 1.0
	public var destinationFrom = CGPoint(x: 0.0, y: 0.0)
	public var destinationTo = CGPoint(x: 1.0, y: 1.0)
	
	lazy var linearConverter : LinearValuesConverter = {
		let converter = LinearValuesConverter()
		converter.sourceMin = sourceMin;
		converter.sourceMax = sourceMax;
		converter.destinationMin = Double(destinationFrom.x);
		converter.destinationMax = Double(destinationTo.x);
		
		return converter;
	}()
	
	
	open func convertSourceToDestination(source: TypeSource) -> TypeDestination{
		guard !checkForEquality() else {
			return destinationFrom
		}
		
		self.prepareConverterForX()
		let xValue = self.linearConverter.convertSourceToDestination(source: source)
		self.prepareConverterForY()
		let yValue = self.linearConverter.convertSourceToDestination(source: source)
		
		return CGPoint(x: xValue, y: yValue)
	}
	
	
	open func convertDestiantionToSource(destination: TypeDestination) -> TypeSource{
		guard !checkForEquality() else {
			return sourceMin
		}
		
		self.prepareConverterForX()
		let value = self.linearConverter.convertDestiantionToSource(destination: Double(destination.x))
		return value
	}
	
	func checkForEquality() -> Bool {
		let equal = !(sourceMin != sourceMax && destinationTo != destinationFrom)
		return equal
	}
	
	func prepareConverterForX() {
		linearConverter.sourceMin = sourceMin;
		linearConverter.sourceMax = sourceMax;
		linearConverter.destinationMin = Double(destinationFrom.x);
		linearConverter.destinationMax = Double(destinationTo.x);
	}
	
	func prepareConverterForY() {
		linearConverter.sourceMin = sourceMin;
		linearConverter.sourceMax = sourceMax;
		linearConverter.destinationMin = Double(destinationFrom.y);
		linearConverter.destinationMax = Double(destinationTo.y);
	}
	
	
 }

