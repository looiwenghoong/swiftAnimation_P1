//
//  ViewController.swift
//  CADisplayLink
//
//  Created by looiwenghoong on 19/09/2018.
//  Copyright © 2018 looiwenghoong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let countingLabel: UILabel = {
        let cLtext = UILabel()
        cLtext.text = "1234"
        cLtext.textAlignment = .center
        cLtext.font = UIFont.boldSystemFont(ofSize: 18)
        return cLtext
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(countingLabel)
        countingLabel.frame = view.frame
        
        let displayLink = CADisplayLink(target: self, selector: #selector(updateLabel))
        displayLink.add(to: .main, forMode: .default)
    }
    
    
    var startValue: Double = 0
    var endValue:Double = 12030
    
    let timeDuration: Double = 1.5
    
    let animationStartTime = Date()
    
    @objc func updateLabel()
    {
        let now = Date()
        let elapsedTime = now.timeIntervalSince(animationStartTime)
        
        if elapsedTime > timeDuration
        {
            self.countingLabel.text = "\(endValue)"
        }
        else
        {
            let percentage = elapsedTime / timeDuration
            let value = startValue + percentage * (endValue - startValue)
            
            self.countingLabel.text = "\(value)"
        }
    }
}

