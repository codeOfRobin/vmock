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
import SwiftyJSON

class ViewController: UIViewController {
    let scrollView = UIScrollView()
    let gradView = UIView()
    let imgView = pdfView()
    var newImgView = UIView()
    var pdfSections :[UIView] = []
    let analysisHeight:CGFloat = 130
    let margin:CGFloat = 10
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 53/255, green: 172/255, blue: 1, alpha: 1)
        scrollView.frame = self.view.frame
        let computedWidth = view.frame.width - 20
        imgView.frame = CGRectMake(0, 0, computedWidth, 1.414*computedWidth )
        imgView.center = view.center
        view.addSubview(scrollView)
        scrollView.addSubview(imgView)
        scrollView.contentSize = CGSizeMake(view.frame.width, 1500)
        
        gradView.frame = CGRectMake(0.0, imgView.frame.origin.y - 8, view.frame.width, 16)
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = gradView.bounds
        gradient.colors = [UIColor(white: 1, alpha: 0).CGColor, UIColor(red: 1, green: 0.62, blue: 0.082, alpha: 1).CGColor,UIColor(white: 1, alpha: 0).CGColor]
        gradView.layer.insertSublayer(gradient, atIndex: 0)
        scrollView.addSubview(gradView)
        
        
        newImgView = imgView.resizableSnapshotViewFromRect(CGRectMake(0, 0, imgView.frame.width, imgView.frame.height), afterScreenUpdates: true, withCapInsets: UIEdgeInsets.init())
        newImgView.frame = imgView.frame
        imgView.removeFromSuperview()
        scrollView.addSubview(newImgView)
        pdfSections.append(newImgView)
        
        scrollView.bringSubviewToFront(gradView)
        
        UIView.animateWithDuration(2, delay: 0, options: [UIViewAnimationOptions.Repeat,UIViewAnimationOptions.CurveEaseInOut, UIViewAnimationOptions.Autoreverse], animations: { () -> Void in
            self.gradView.transform = CGAffineTransformMakeTranslation(0,self.imgView.frame.height)
            }, completion: { (completed) -> Void in
        })
        Alamofire.request(.POST, "https://robin.localtunnel.me")
            .responseJSON { response in
                print(response.result.value)
                UIView.animateWithDuration(1.5, delay: 0, options: [UIViewAnimationOptions.BeginFromCurrentState,UIViewAnimationOptions.CurveEaseInOut], animations: { () -> Void in
                        self.gradView.transform = CGAffineTransformMakeTranslation(0, 0)
                    }, completion: { (competed) -> Void in
                        if let value = response.result.value
                        {
                            let json = JSON(value)
                            self.showResults(json)
                        }
                })
                

        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func showResults(value:JSON)
    {
        if let sections = value["sections"].array
        {
            for (index,section) in sections.enumerate()
            {
                UIView.animateWithDuration(2, delay: Double(3)*Double(index), options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                    self.gradView.frame.origin.y += CGFloat(section["height"].double!) + CGFloat(index)*(self.analysisHeight + 2*self.margin)
                    }, completion: { (completed) -> Void in
                        
                        print(self.gradView.frame.origin.y)
                        let toCut = self.pdfSections.removeLast()

                        let split1 = toCut.resizableSnapshotViewFromRect(CGRectMake(0, 0, toCut.frame.width, CGFloat(section["height"].doubleValue)), afterScreenUpdates: true, withCapInsets: UIEdgeInsets.init())
                        
                        let split2 = toCut.resizableSnapshotViewFromRect(CGRectMake(0, CGFloat(section["height"].doubleValue), toCut.frame.width, toCut.frame.height - CGFloat(section["height"].doubleValue)), afterScreenUpdates: true, withCapInsets: UIEdgeInsets.init())
                        split1.frame.origin = toCut.frame.origin
                        split2.frame.origin.x = toCut.frame.origin.x
                        split2.frame.origin.y = split1.frame.origin.y + CGFloat(section["height"].doubleValue)
                        
                        self.scrollView.addSubview(split1)
                        self.scrollView.addSubview(split2)
                        self.pdfSections.append(split1)
                        self.pdfSections.append(split2)
                        toCut.removeFromSuperview()
                        self.scrollView.bringSubviewToFront(self.gradView)
                        let analysis = analysisView(frame: CGRectMake(10,split1.frame.origin.y+split1.frame.height+10,split1.frame.width,130))
                        let jsonArray = section["analysis"].array
                        
                        var stringArray :[String] = []
                        for jsonString in jsonArray!
                        {
                            stringArray.append(jsonString.string!)
                        }
                        analysis.texts = stringArray
                        analysis.setTextsAndCreateScroller()
                        analysis.opaque = false
                        analysis.layer.cornerRadius = 6
                        analysis.layer.masksToBounds = true
                        analysis.alpha = 0
                        analysis.transform = CGAffineTransformMakeTranslation(0, -30)
                        self.scrollView.addSubview(analysis)
                        self.scrollView.bringSubviewToFront(self.gradView)
                        UIView.animateWithDuration(1, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                            split2.frame.origin.y+=self.analysisHeight + self.margin*2
                            analysis.alpha = 1
                            analysis.transform = CGAffineTransformIdentity
                            }, completion: { (completed) -> Void in
                                
                        })
                })
            }
        }
    }
    
      override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

