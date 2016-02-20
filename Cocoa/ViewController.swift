//
//  ViewController.swift
//  Cocoa
//
//  Created by ShinokiRyosei on 2016/02/16.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import UIKit
import Parse
import SVProgressHUD

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var table: UITableView!
    private var contentArray: [String] = [String]()
    private var idArray: [String] = []
    private var id: String!
    private var text: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        table.registerNib(nib, forCellReuseIdentifier: "Cell")
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.read()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func read() {
        SVProgressHUD.show()
        self.contentArray.removeAll()
        self.idArray.removeAll()
        let query: PFQuery = PFQuery(className: Data.parseClassName())
        query.orderByDescending("createdAt")
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if error == nil {
                if let dataObjects: [PFObject] = objects! {
                    for dataObject in dataObjects {
                        self.contentArray.append(dataObject["content"] as! String)
                        self.idArray.append(dataObject.objectId!)
                    }
                    print("contentArray...\(self.contentArray)")
                    SVProgressHUD.showSuccessWithStatus("Succeeded to read")
                }
                
                self.table.reloadData()
            }
        }
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! TableViewCell
//        cell.createdAtLabel.text = contentArray[indexPath.row]["createdAt"] as? String
        cell.contentLabel.text = contentArray[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentArray.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        id = idArray[indexPath.row]
        text = contentArray[indexPath.row]
        self.performSegueWithIdentifier("toUpdate", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toUpdate" {
            let updateVC = segue.destinationViewController as! UpdateViewController
            updateVC.id = self.id
            updateVC.text = self.text
        }
    }
    
    


}

