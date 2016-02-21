//
//  AddViewController.swift
//  Cocoa
//
//  Created by ShinokiRyosei on 2016/02/16.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import UIKit
import Parse
import SVProgressHUD

class AddViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var textField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTapedPostButton(sender: UIButton) {
        if textField.text != "" {
            self.create(textField.text!)
            self.backToHome()
        }else {
            self.showAlert()
        }
    }
    
    //String型の引数をParseに送信
    //CRUDのC (Create)
    func create(content: String) {
        let postObject: Data = Data(content: content)
        postObject.saveInBackground()
        SVProgressHUD.showSuccessWithStatus("Succeeded to save")
        
    }
    
    
    //TextFieldに入力してないときに、Alertを表示
    func showAlert() {
        let alert = UIAlertController(title: "文字を入力してください", message: "文字を入力せずに、POSTはできません", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        //ViewControllerに戻る
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    //エンターを押した段階で、キーボードを閉じる
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.create(textField.text!)
        return true
    }
    
    
    //遅延させた後、ViewControllerに戻る
    func backToHome() {
        let delay = 3.5 * Double(NSEC_PER_SEC) //時間の指定
        let time  = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue(), {
            //ここにコードを書く (今は4.5秒後に実行される)
            self.navigationController?.popViewControllerAnimated(true)
        })
    }
    
    
    
    

}
