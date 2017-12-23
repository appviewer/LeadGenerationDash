//
//  Lead.swift
//  Josh
//
//  Created by Joshua Davis on 11/11/17.
//  Copyright © 2017 Joshua Davis. All rights reserved.
//

import Foundation

struct Lead {
    
    // MARK: - Properties
    var = ""
    var = ""
    var = ""
    var = []()
    var  = ""
    var  = ""
    
    // MARK: - Initializer
    init(with json: JSON) {
        if let  = json[""] as? String {
            self. = 
        }
        
        if let  = json[""] as? String {
            self. = Helpers.(from: )
        }
        
        if let  = json[""] as? String {
            self. = 
        }
        
        // sampleJSON.
        if let  = json[""] as? JSON {
            if let  = [""] as? JSONArray {
                for sampleJSON in  {
                    self..append(...(with: sampleJSON))
                }
            }
        }
    }

    // MARK: - Public API
    func () -> String {
        return "\() \()"
    }
    
}
