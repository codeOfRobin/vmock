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
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.frame = CGRectMake(0, 300, view.frame.width, view.frame.height)
        tableView.backgroundColor = UIColor.clearColor()
        tableView.backgroundView?.backgroundColor = UIColor.clearColor()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerClass(MyTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.scrollEnabled = false
        let pg = UIPanGestureRecognizer(target: self, action: "panned:")
        pg.delegate = self
        tableView.addGestureRecognizer(pg)
        view.addSubview(tableView)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
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
        cell.backgroundColor = UIColor.redColor()
        cell.textLabel?.text = String(indexPath.row)
        cell.detailTextLabel?.text = "SDAfsadfhkasdfnkjsa"
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath:indexPath) as! MyTableViewCell
        return cell
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool)
    {
        if(tableView.scrollEnabled == true && scrollView.contentOffset.y < -100)
        {

            tableView.gestureRecognizers![2].enabled = true
            tableView.scrollEnabled = false
            UIView.animateWithDuration(0.7, animations: { () -> Void in
                self.tableView.frame = CGRectMake(0, 300, self.view.frame.width, self.view.frame.height)
                self.tableView.transform = CGAffineTransformMakeTranslation(0, 0)
            })

        }
    }
    
    func panned(sender:UIPanGestureRecognizer)
    {
        print(sender.velocityInView(view))
        if(sender.velocityInView(view).y < -200)
        {
            sender.enabled = false
            tableView.scrollEnabled = true
            UIView.animateWithDuration(0.7, animations: { () -> Void in
                self.tableView.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height)
                self.tableView.transform = CGAffineTransformMakeTranslation(0, 0)
            })
        }
        if(sender.state == UIGestureRecognizerState.Ended)
        {
            latestTransform += sender.translationInView(view).y
        }
        else
        {
            tableView.transform = CGAffineTransformMakeTranslation(0, sender.translationInView(view).y+latestTransform)
        }
        print(latestTransform)
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