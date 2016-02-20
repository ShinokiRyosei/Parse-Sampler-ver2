//
//  AddViewController.swift
//  Cocoa
//
//  Created by ShinokiRyosei on 2016/02/16.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import UIKit
import Parse

class AddViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var postButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTapedPostButton(sender: UIButton) {
        if textField.text != nil {
            self.create(textField.text!)
            self.backToView()
        }else {
            self.showAlert()
        }
    }
    
    //String型の引数をParseに送信
    //CRUDのC (Create)
    func create(content: String) {
        let postObject: Data = Data(content: content)
        postObject.saveInBackground()
    }
    
    
    
    //ViewControllerに戻る
    func backToView() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //TextFieldに入力してないときに、Alertを表示
    func showAlert() {
        let alert = UIAlertController(title: "文字を入力してください", message: "文字を入力せずに、POSTはできません", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    //エンターを押した段階で、キーボードを閉じる
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.create(textField.text!)
        return true
    }
    
    
    
    

}
