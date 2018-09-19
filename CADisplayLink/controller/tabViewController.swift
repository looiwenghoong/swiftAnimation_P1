//
//  tabViewController.swift
//  CADisplayLink
//
//  Created by looiwenghoong on 19/09/2018.
//  Copyright © 2018 looiwenghoong. All rights reserved.
//

import UIKit

class tabViewContoller: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstViewContoller = ViewController()
        firstViewContoller.title = "First"
        firstViewContoller.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)], for: .normal)
        firstViewContoller.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -10)
        
        let secondViewController = nextViewController()
        secondViewController.title = "Second"
        secondViewController.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)], for: .normal)
        secondViewController.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -10)
        
        
        //  Add the created view controllers into the array to be displayed
        viewControllers = [firstViewContoller, secondViewController]
        
    }
}
