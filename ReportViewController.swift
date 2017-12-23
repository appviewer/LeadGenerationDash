//
//  ReportViewController.swift
//  Josh
//
//  Created by Joshua Davis on 11/10/17.
//  Copyright © 2017 Joshua Davis. All rights reserved.
//

import UIKit

class ReportViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var sampleLabel: UILabel!
    @IBOutlet weak var fromDatePicker: UIDatePicker!
    @IBOutlet weak var toDatePicker: UIDatePicker!
    var headers = [String]() {
        didSet {
            var headersText = ""
            
            for header in headers {
                headersText = "\(headersText)\n\(header)"
            }
            
            label.text = headersText
        }
    }
    var sample = [String]() {
        didSet {
            var sampleText = ""
            
            for sample in samples {
                sampleText = "\(samplesText)\n\(sample)"
            }
            
            sampleLabel.text = sampleText
        }
    }
    
    // MARK: - Actions
    @IBAction func runSampleButtonTapped() {
        loadData()
    }
    
    // MARK: - Private API
    fileprivate func loadData() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        let fromDate = fromDatePicker.date
        let toDate = toDatePicker.date
        let query = "Date_Start=\(Helpers.getDateString(from: fromDate))&Date_End=\(Helpers.getDateString(from: toDate))"
        
        let sampleURL = "\(Endpoints.samples)&\(query)"
        print(sampleURL)
        
        RESTManager.shared.loadData(from: samplesURL, method: .get, parameters: nil) { (status, response) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            if let json = response as? JSON {
                print(json)
                
                if let response = json["response"] as? JSON {
                    if let sampleData = response["sample_data"] as? JSON {
                        
                        // Headers
                        if let headers = sampletData["headers"] as? JSON {
                            if let header = headers["header"] as? [String] {
                                self.headers = header
                                print(self.headers)
                            }
                        }
                        
                        // Rows
                        if let rows = sampleData["rows"] as? JSON {
                            if let row = rows["row"] as? JSONArray {
                                if let firstRow = row.first {
                                    if let col = firstRow["col"] as? [String] {
                                        self.samples = col
                                        print(self.samples)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
}
