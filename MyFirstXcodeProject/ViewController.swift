//
//  ViewController.swift
//  MyFirstXcodeProject
//
//  Created by kingkong999yhirose on 2017/07/17.
//  Copyright © 2017年 kingkong999yhirose. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var pushButton: UIButton!
    @IBOutlet weak var animationButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pushButton.setTitleColor(UIColor.orange, for: UIControlState.normal)
        
        animationButton.layer.borderColor = UIColor.black.cgColor
        animationButton.layer.borderWidth = 1
    }

    @IBAction func pushButtonPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "SecondViewController", bundle: nil)
        let second = storyboard.instantiateInitialViewController()
        navigationController?.pushViewController(second!, animated: true)
    }
    
    @IBAction func animationButtonPressed(_ sender: Any) {
        let timing = UICubicTimingParameters(animationCurve: .easeInOut)
        let animator = UIViewPropertyAnimator(duration: 1, timingParameters: timing)
        
        animator.addAnimations {
            self.animationButton.frame.size = CGSize(width: 100, height: 100)
        }
        
        let originalSize = animationButton.frame.size
        animator.addCompletion { (position) in
            let secondAnimator = UIViewPropertyAnimator(duration: 1, timingParameters: timing)
            
            secondAnimator.addAnimations {
                self.animationButton.frame.size = originalSize
            }
            
            secondAnimator.startAnimation()
        }
        
        animator.startAnimation()
    }
}

