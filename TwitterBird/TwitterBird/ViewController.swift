//
//  ViewController.swift
//  TwitterBird
//
//  Created by MinJing_Lin on 2020/6/10.
//  Copyright © 2020 MinJing_Lin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CAAnimationDelegate {

    var maskView : UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.view.backgroundColor = .white
        let bgImageView = UIImageView(image: UIImage(named: "twitterBG.jpeg"))
        bgImageView.frame = self.view.frame
        self.view.addSubview(bgImageView)
        
        let logoLayer = CALayer()
        logoLayer.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        logoLayer.position = view.center
        logoLayer.contents = UIImage(named: "logo")?.cgImage
        view.layer.mask = logoLayer
        
        maskView = UIView(frame: view.frame)
        maskView.backgroundColor = .white
        view.addSubview(maskView)
        
        let appDelegate = UIApplication.shared.delegate
        let window = appDelegate?.window!
        window?.backgroundColor = UIColor(red: 29 / 255.0, green: 161 / 255.0, blue: 242 / 255.0, alpha: 1)
        
        let logoAnimation = CAKeyframeAnimation(keyPath: "bounds")
        logoAnimation.beginTime = CACurrentMediaTime() + 1
        logoAnimation.duration = 1
        logoAnimation.keyTimes = [0, 0.4, 1]
        logoAnimation.values = [NSValue(cgRect: CGRect(x: 0, y: 0, width: 100, height: 100)),NSValue(cgRect: CGRect(x: 0, y: 0, width: 85, height: 85)),NSValue(cgRect: CGRect(x: 0, y: 0, width: 4000, height: 4000))]
        logoAnimation.timingFunctions = [CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut),CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)]
        logoAnimation.fillMode = CAMediaTimingFillMode.forwards
        logoLayer.add(logoAnimation, forKey: "zoomAnimation")
        
        let logoOpacityAnimation = CABasicAnimation(keyPath: "opacity")
        logoOpacityAnimation.beginTime = CACurrentMediaTime() + 1
        logoOpacityAnimation.duration = 1
        logoOpacityAnimation.fromValue = 1
        logoOpacityAnimation.toValue = 0
        logoOpacityAnimation.delegate = self
        maskView.layer.add(logoOpacityAnimation, forKey: "opacityAnimation")
        
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        self.maskView.removeFromSuperview()
        self.view.layer.mask = nil
    }


}

