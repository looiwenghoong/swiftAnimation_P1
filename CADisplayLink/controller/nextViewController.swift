//
//  nextViewController.swift
//  CADisplayLink
//
//  Created by looiwenghoong on 19/09/2018.
//  Copyright © 2018 looiwenghoong. All rights reserved.
//
//  Tutorial for CAAnimation and CAShapeLayer

import UIKit

class nextViewController: UIViewController {
    
    //  Create the calayer shapeobject
    let shapelayer = CAShapeLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let center = view.center
    
        let hiddenLayer = CAShapeLayer() // Hidden layer of the shape
        
        //  the path and the specifications of drawing out the shape
        let circularPath = UIBezierPath(arcCenter: center, radius: 100, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        // Customization for the hidden layer of the arc
        hiddenLayer.path = circularPath.cgPath
        hiddenLayer.strokeColor = UIColor.lightGray.cgColor
        hiddenLayer.lineWidth = 10
        hiddenLayer.fillColor = UIColor.clear.cgColor
        view.layer.addSublayer(hiddenLayer)
        
        // Customization for the outer layer of the arc
        shapelayer.path = circularPath.cgPath
        shapelayer.strokeColor = UIColor.red.cgColor
        shapelayer.lineWidth = 10
        shapelayer.lineCap = .round
        shapelayer.strokeEnd = 0
        shapelayer.fillColor = UIColor.clear.cgColor
        view.layer.addSublayer(shapelayer)
        
        // add gesture recogizer to the view so that upon tapping the screen, some kind of action can be added into the view
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    @objc func handleTap()
    {
        //  Create the animation
        let basicAnimation  = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 1
        basicAnimation.duration = 2 // Set the duration of the animation to 2s
        basicAnimation.fillMode = .forwards
        basicAnimation.isRemovedOnCompletion = false
        
        shapelayer.add(basicAnimation, forKey: "Anything")
    }
}
