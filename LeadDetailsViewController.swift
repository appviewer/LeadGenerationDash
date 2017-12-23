//
//  LeadDetailsViewController.swift
//  Josh
//
//  Created by Joshua Davis on 11/13/17.
//  Copyright © 2017 Joshua Davis. All rights reserved.
//

import UIKit

class LeadDetailsViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var textLabel: UILabel!
    var sample: Sample?
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let sample = Sample {
            if let example = lead.sampleSample.first {
                textLabel.text = example.toString()
            }
        }
    }
    
}
