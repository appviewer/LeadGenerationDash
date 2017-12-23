//
//  CallCenterDetailsViewController.swift
//  Josh
//
//  Created by Djuro Alfirevic on 11/15/17.
//  Copyright © 2017 Joshua Davis. All rights reserved.
//

import UIKit

class CallCenterDetailsViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var textLabel: UILabel!
    var test : Test?
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let test = Test {
            if let partner = test.testTest.first {
                textLabel.text = test1.toString()
            }
        }
    }
    
}
