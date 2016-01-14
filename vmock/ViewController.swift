//
//  ViewController.swift
//  vmock
//
//  Created by Robin Malhotra on 12/01/16.
//  Copyright © 2016 Robin Malhotra. All rights reserved.
//

import UIKit
import Alamofire
import GradientView


class ViewController: UIViewController {
    let scrollView = UIScrollView()
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 53/255, green: 172/255, blue: 1, alpha: 1)
        scrollView.frame = self.view.frame
        let imgView = pdfView()
        let computedWidth = view.frame.width - 20
        imgView.frame = CGRectMake(0, 0, computedWidth, 1.414*computedWidth )
        imgView.center = view.center
        view.addSubview(scrollView)
        scrollView.addSubview(imgView)
        scrollView.contentSize = CGSizeMake(1000, 1000)
        let gradView: UIView = UIView(frame: CGRectMake(0.0, 100.0, view.frame.width, 16))
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.backgroundColor = UIColor.clearColor().CGColor
        gradient.frame = gradView.bounds
        gradient.colors = [UIColor.clearColor().CGColor, UIColor(red: 1, green: 0.62, blue: 0.082, alpha: 1).CGColor,UIColor.clearColor().CGColor]
        gradView.layer.insertSublayer(gradient, atIndex: 0)
        view.addSubview(gradView)
        
        let snap = imgView.resizableSnapshotViewFromRect(CGRectMake(0, 0, 200, 400), afterScreenUpdates: true, withCapInsets: UIEdgeInsets.init())
        snap.frame = CGRectMake(400, 400, 200, 400)
        scrollView.addSubview(snap)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
      override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

