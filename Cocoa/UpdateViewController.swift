//
//  UpdateViewController.swift
//  Cocoa
//
//  Created by ShinokiRyosei on 2016/02/19.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import UIKit
import Parse
import SVProgressHUD

class UpdateViewController: UIViewController, UITextViewDelegate {
    
    var id: String!
    var text: String!
    @IBOutlet weak var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.delegate = self
        let deleteButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Trash, target: self, action: "delete")
//        navigationController?.navigationItem.rightBarButtonItem = deleteButton
        self.navigationItem.rightBarButtonItem = deleteButton

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        textView.text = text
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func post(sender: UIButton) {
        self.update()
        
        
    }
    
    func textViewShouldEndEditing(textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
    }
    
    //更新
    func update() {
        print("id...\(id)")
        let query: PFQuery = PFQuery(className: Data.parseClassName())
        query.getObjectInBackgroundWithId(id) { (object, error) -> Void in
            SVProgressHUD.show()
            if error == nil {
                if let parseObject: Data = object! as! Data {
                    parseObject["content"] = self.textView.text!
                    parseObject.saveInBackground()
                    SVProgressHUD.showSuccessWithStatus("Succeeded to update")
                }else {
                    print("\(error?.localizedDescription)")
                    SVProgressHUD.showErrorWithStatus("Failed to update")
                }
            }
            
        }
//        self.dismissViewControllerAnimated(true, completion: nil)
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    //削除
    func delete() {
        SVProgressHUD.show()
        let query: PFQuery = PFQuery(className: Data.parseClassName())
        query.getObjectInBackgroundWithId(id) { (object, error) -> Void in
            if error == nil {
                object?.deleteInBackground()
                SVProgressHUD.showSuccessWithStatus("Succeeded to delete")
            }else {
                print("\(error?.localizedDescription)")
                SVProgressHUD.showErrorWithStatus("Failed to delete")
            }
        }
//        self.dismissViewControllerAnimated(true, completion: nil)
        self.navigationController?.popViewControllerAnimated(true) 
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
