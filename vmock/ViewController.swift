//
//  ViewController.swift
//  vmock
//
//  Created by Robin Malhotra on 29/11/15.
//  Copyright © 2015 Robin Malhotra. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate {
    let tableView = UITableView()
    var latestTransform = CGFloat(0)
    let segment = UISegmentedControl(items: ["Impact","Presentation","Competencies"])
    let webView = UIWebView(frame: CGRectMake(0, 0, 375,667 ))

    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.frame = CGRectMake(0, 0, view.frame.width, view.frame.height)
        tableView.backgroundColor = UIColor.clearColor()
        tableView.backgroundView?.backgroundColor = UIColor.clearColor()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerClass(MyTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.contentInset.top = 300
        tableView.separatorStyle = .None
        
        let header = UIVisualEffectView(frame: CGRectMake(0, 0, view.frame.width
        , 44))
        header.effect = UIBlurEffect(style: .Light)
        segment.frame = CGRectMake(16, 8, view.frame.width - 32, 29)
        segment.selectedSegmentIndex = 0
        segment.addTarget(self, action: "segmentChanged:", forControlEvents: .ValueChanged)
        header.addSubview(segment)
        tableView.tableHeaderView = header
        
        
        let scroller = UIScrollView(frame: CGRectMake(0,0,view.frame.width,300))
        scroller.backgroundColor = UIColor.clearColor()
        scroller.contentSize = CGSizeMake(view.frame.width, 300)
        
        webView.scrollView.contentInset.bottom = view.frame.height - 300
        let path = NSBundle.mainBundle().pathForResource("cv", ofType: "pdf")
        let url = NSURL(fileURLWithPath: path!)
        let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
        var req :NSURLRequest
        if(appDel.url != nil)
        {
            req = NSURLRequest(URL: appDel.url!)
        }
        else
        {
            req = NSURLRequest(URL: url)
        }
        webView.loadRequest(req)
        webView.scalesPageToFit = true
        scroller.addSubview(webView)
        tableView.backgroundView = scroller
        webView.userInteractionEnabled = true
        webView.scrollView.scrollEnabled = true

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "viewWillAppear:", name: UIApplicationWillEnterForegroundNotification, object: nil)
        
        
        let pg = UITapGestureRecognizer(target: self, action: "panned:")
        pg.delegate = self
        scroller.addGestureRecognizer(pg)

        view.addSubview(tableView)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        let path = NSBundle.mainBundle().pathForResource("cv", ofType: "pdf")
        let url = NSURL(fileURLWithPath: path!)
        let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
        var req :NSURLRequest
        if(appDel.url != nil)
        {
            req = NSURLRequest(URL: appDel.url!)
        }
        else
        {
            req = NSURLRequest(URL: url)
        }
        webView.loadRequest(req)

    }
    
    func segmentChanged(sender:UISegmentedControl)
    {
        tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 20
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath)
    {
        cell.textLabel?.text = String(indexPath.row)
        cell.detailTextLabel?.text = "This is the error for row " + String(indexPath.row) + " in " + segment.titleForSegmentAtIndex(segment.selectedSegmentIndex)!
    }
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath:indexPath) as! MyTableViewCell
        cell.backgroundColor = UIColor.clearColor()
        let blur = UIVisualEffectView(frame: cell.frame)
        blur.effect = UIBlurEffect(style: .ExtraLight)
        cell.backgroundView = blur
        let but = UIButton(frame: CGRectMake(view.frame.width-8-72,16,66,66))
        but.layer.cornerRadius = 20
        but.titleLabel?.text = "dsaf"
        but.backgroundColor = UIColor.redColor()
        cell.addSubview(but)
        but.addTarget(self, action: "tapped:", forControlEvents: .TouchUpInside)
        return cell
    }
    func tapped(sender:UIButton)
    {
        let cell = sender.superview as! MyTableViewCell
        print(tableView.indexPathForCell(cell)?.row)
        
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(indexPath.row)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//
//    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool)
//    {
//        if(tableView.scrollEnabled == true && scrollView.contentOffset.y < -100)
//        {
//
//            tableView.gestureRecognizers![2].enabled = true
//            tableView.scrollEnabled = false
//            UIView.animateWithDuration(0.7, animations: { () -> Void in
//                self.tableView.frame = CGRectMake(0, 300, self.view.frame.width, self.view.frame.height)
//                self.tableView.transform = CGAffineTransformMakeTranslation(0, 0)
//                self.latestTransform = 0
//            })
//
//        }
//    }
//    
    func panned(sender:UIPanGestureRecognizer)
    {
        print("tap that pg")
//        
//        if(latestTransform+sender.translationInView(view).y < -100)
//        {
//            self.tableView.scrollEnabled = true
//            sender.enabled = false
//        }
        
        
//        if(sender.velocityInView(view).y < -1500)
//        {
//            sender.enabled = false
//            tableView.scrollEnabled = true
//            UIView.animateWithDuration(0.7, animations: { () -> Void in
//                self.tableView.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height)
//                self.tableView.transform = CGAffineTransformMakeTranslation(0, 0)
//            })
//        }
//        if(sender.state == UIGestureRecognizerState.Ended && sender.translationInView(view).y > 0)
//        {
//            latestTransform += sender.translationInView(view).y
//        }
//        else
//        {
//            tableView.transform = CGAffineTransformMakeTranslation(0, sender.translationInView(view).y+latestTransform)
//        }
    }

}

class MyTableViewCell : UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: UITableViewCellStyle.Subtitle, reuseIdentifier: reuseIdentifier)

    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}