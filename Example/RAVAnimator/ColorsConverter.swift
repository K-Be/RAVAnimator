//
//  ColorsConverter.swift
//  RAVAnimator_Example
//
//  Created by Andrew Romanov on 02/07/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import RAVAnimator
import UIKit


public class ColorsConverter : ValuesConverterP {
	
	public typealias TypeDestination = UIColor
	public typealias TypeSource = Double
	
	public var sourceMin = 0.0 {
		didSet{
			converterR.sourceMin = self.sourceMin
			converterG.sourceMin = self.sourceMin
			converterB.sourceMin = self.sourceMin
			converterA.sourceMin = self.sourceMin
		}
	}
	
	public var sourceMax = 0.0 {
		didSet {
			converterR.sourceMax = self.sourceMax
			converterG.sourceMax = self.sourceMax
			converterB.sourceMax = self.sourceMax
			converterA.sourceMax = self.sourceMax
		}
	}
	
	public var fromColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0) {
		didSet {
			
			var red : CGFloat = 0.0
			var green : CGFloat = 0.0
			var blue : CGFloat = 0.0
			var alpha : CGFloat = 0.0
			
			guard fromColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha) else {
				assert(false, "should use RGB compatible color")
				return
			}
			
			converterR.destinationMin = Double(red)
			converterG.destinationMin = Double(green)
			converterB.destinationMin = Double(blue)
			converterA.destinationMin = Double(alpha)
		}
	}
	
	public var toColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) {
		didSet {
			var red : CGFloat = 0.0
			var green : CGFloat = 0.0
			var blue : CGFloat = 0.0
			var alpha : CGFloat = 0.0
			
			guard toColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha) else {
				assert(false, "should use RGB compatible color")
				return
			}
			
			converterR.destinationMax = Double(red)
			converterG.destinationMax = Double(green)
			converterB.destinationMax = Double(blue)
			converterA.destinationMax = Double(alpha)
		}
	}
	
	public init() {
		
		self.sourceMin = 0.0
		self.sourceMax = 0.0
		self.fromColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
		self.toColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0);
	}
	
	lazy var converterR = LinearValuesConverter()
	lazy var converterG = LinearValuesConverter()
	lazy var converterB = LinearValuesConverter()
	lazy var converterA = LinearValuesConverter()
	
	public func convertSourceToDestination(source: Double) -> UIColor {
		let r = self.converterR.convertSourceToDestination(source: source)
		let g = self.converterG.convertSourceToDestination(source: source)
		let b = self.converterB.convertSourceToDestination(source: source)
		let a = self.converterA.convertSourceToDestination(source: source)
		
		let color = UIColor(red: CGFloat(r), green: CGFloat(g), blue: CGFloat(b), alpha: CGFloat(a))
		return color
	}
	
	public func convertDestiantionToSource(destination: UIColor) -> Double {
		var red : CGFloat = 0.0
		
		guard fromColor.getRed(&red, green: nil, blue: nil, alpha: nil) else {
			assert(false, "should use RGB compatible color")
			return sourceMin
		}
		
		let value = self.converterR.convertDestiantionToSource(destination: Double(red))
		return value
	}
	
}
