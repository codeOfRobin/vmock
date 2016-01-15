//
//  analysisView.swift
//  vmock
//
//  Created by Robin Malhotra on 15/01/16.
//  Copyright © 2016 Robin Malhotra. All rights reserved.
//

import UIKit

class analysisView: UIView,UIScrollViewDelegate {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    let pageControl = UIPageControl(frame: CGRectMake(0,0,300,40))
    let scroller = UIScrollView()
    var texts :[String] = ["","",""]
    override init(frame: CGRect)
    {
        super.init(frame: frame)
    }

    func setTextsAndCreateScroller()
    {
        scroller.delegate = self
        pageControl.center.x = self.center.x
        pageControl.numberOfPages = 3
        pageControl.pageIndicatorTintColor = UIColor.orangeColor()
        pageControl.currentPageIndicatorTintColor = UIColor.redColor()
        self.addSubview(pageControl)
        print(pageControl.frame)
        pageControl.tintColor = UIColor.orangeColor()
        scroller.frame = self.bounds
        scroller.contentSize = CGSizeMake(self.bounds.width*3, self.bounds.height)
        scroller.backgroundColor = UIColor.whiteColor()
        scroller.pagingEnabled = true
        scroller.showsHorizontalScrollIndicator = false
        for(var i=0 ; i<3 ; i+=1)
        {
            let label = UILabel(frame: CGRectMake(CGFloat(i)*scroller.frame.width+10,10,scroller.frame.width - 10,scroller.frame.height - 10))
            label.textColor = UIColor.orangeColor()
            label.text = texts[i]
            label.numberOfLines = 4
            scroller.addSubview(label)
        }
        self.addSubview(scroller)
        self.bringSubviewToFront(pageControl)
        
    }
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        self.pageControl.currentPage = Int(scrollView.contentOffset.x/self.bounds.width)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
