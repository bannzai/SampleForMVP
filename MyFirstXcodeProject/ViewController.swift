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
        let originalSize = animationButton.frame.size
        UIView.animate(
            withDuration: 1, delay: 0,
            options: .curveEaseOut,
            animations: {
                self.animationButton.frame.size = CGSize(width: 100, height: 100)
        }, completion: { _ in
            self.animationButton.frame.size = originalSize
        })
    }
}

