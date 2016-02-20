//
//  Data.swift
//  Cocoa
//
//  Created by ShinokiRyosei on 2016/02/16.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import UIKit
import Parse

class Data: PFObject, PFSubclassing {
    
    @NSManaged var content: String!
    @NSManaged var created_At: NSDate!
    
    init(content: String) {
        super.init()
        self.content = content
        
    }
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override class func initialize() {
        struct Static {
            static var oneceToken: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.oneceToken) {
            self.registerSubclass()
        }
        
    }
    
    static func parseClassName() -> String {
        
        return "Data"
    }

}
