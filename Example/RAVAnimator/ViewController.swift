//
//  ViewController.swift
//  RAVAnimator
//
//  Created by K-Be on 07/01/2018.
//  Copyright (c) 2018 K-Be. All rights reserved.
//

import UIKit
import RAVAnimator


class ViewController: UIViewController {

	@IBOutlet var startButton : UIButton!
	@IBOutlet var movingView : UIView!
	@IBOutlet var destinationPositionView : UIView!
	@IBOutlet var slider : UISlider!
	
	var startPosition = CGPoint(x: 0.0, y: 0.0)
	
	var animationQueue = OperationQueue()
	var animator = Animator()
	
	override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
		
		self.view.bringSubviewToFront(self.movingView)
    }
	
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		self.startPosition = self.movingView.center
		
		self.startAction(sender: self.startButton)
	}

  override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

	
	func scheduleViewAnimations() {
		
		let pointConverter = PointsConverter()
		pointConverter.sourceMax = 7.0
		pointConverter.destinationFrom = movingView.center
		pointConverter.destinationTo = destinationPositionView.center
				
		let movingAnimationOperation = AnimationOperation(withAnimation: BlockAnimation(withDuration: pointConverter.sourceMax,
																																										animationBlock: {[weak self] (time) in
																																											guard let self = self else {
																																												return;
																																											}
																																											let position = pointConverter.convertSourceToDestination(source: time)
																																											self.movingView.center = position
		}),
																											forAnimator: self.animator)
		let colorConverter = ColorsConverter()
		colorConverter.sourceMax = 3.0
		colorConverter.fromColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0);
		colorConverter.toColor = UIColor(red: 0.2, green: 0.67, blue: 0.9, alpha: 1.0);
		let blockAnimation = BlockAnimation(withDuration: colorConverter.sourceMax) { (time) in
			let color = colorConverter.convertSourceToDestination(source: time)
			self.movingView.backgroundColor = color
		}
		blockAnimation.callWithZero = true
		let colorChangingAnimation = AnimationOperation(withAnimation: blockAnimation,
																										forAnimator: self.animator)
		colorChangingAnimation.addDependency(movingAnimationOperation)
		self.animationQueue.addOperations([movingAnimationOperation, colorChangingAnimation], waitUntilFinished: false)
		
		let complitionOperation = BlockOperation {
			QueueExecutor.execImmidiateOnMainThread {
				self.startButton.isEnabled = true
			}
		};
		
		complitionOperation.addDependency(colorChangingAnimation)
		self.animationQueue.addOperation(complitionOperation)
		
	}
	
	func scheduleSliderAnimation() {
		let valuesConvertor = LinearValuesConverter()
		valuesConvertor.destinationMin = Double(self.slider.minimumValue)
		valuesConvertor.destinationMax = Double(self.slider.maximumValue)
		valuesConvertor.sourceMax = 10.0
		let animation = BlockAnimation(withDuration: valuesConvertor.sourceMax) { (time) in
			let sliderValue = valuesConvertor.convertSourceToDestination(source: time)
			self.slider.value = Float(sliderValue)
		}
		
		self.animator.add(animation: animation)
	}
	
	@IBAction func startAction(sender: AnyObject) {
		self.movingView.center = self.startPosition
		self.movingView.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
		self.startButton.isEnabled = false
		
		self.scheduleSliderAnimation()
		self.scheduleViewAnimations()
		
	}
	
}

