//
//  Report.swift
//  Josh
//
//  Created by System Administrator on 11/28/17.
//  Copyright © 2017 Joshua Davis. All rights reserved.
//

import Foundation

struct Report {
    
    // MARK: - Properties
    var  = ()
    var : ?
    var  = ""
    var  = ""
    var  = ""
    var  = []()
    
    // MARK: - Initializer
    init(with json: JSON) {
        if let  = json[""] as? String {
            self. = 
        }
        
        if let  = json[""] as? String {
            if let  = Helpers.(from: ) {
                self. = 
            }
        }
        
        if let  = json[""] as? String {
            self. = Helpers.(from: )
        }
        
        if let  = json[""] as? String {
            self. = 
        }
        
        if let  = json[""] as? String {
            self. = 
        }
        

        if let  = json[""] as? JSON {
            if let  = [""] as? JSONArray {
                for exampleJSON in  {
                    .append((with: exampleJSON))
                }
            }
        }
    }
    
}
