//
//  CallCenterViewController.swift
//  Josh
//
//  Created by Joshua Davis on 11/10/17.
//  Copyright © 2017 Joshua Davis. All rights reserved.
//

import UIKit

class CallCenterViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    var sample = [Sample]()
    
    // MARK: - Private API
    fileprivate func loadData() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        RESTManager.shared.loadData(from: Endpoints.calls, method: .get, parameters: nil) { (status, response) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            print(Endpoints.calls)
            
            if let call = response as? JSON {
                print(call)
                
                if let call = json["calls"] as? JSON {
                    if let calls = response["missedCalls"] as? JSON {
                        if let missedCalls = leads["voiceMail"] as? JSONArray {
                            for sampleJSON in sample {
                                self.sample.append(Sample(with: sampleJSON))
                            }
                            
                            self.tableView.reloadData()
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
    }
    
    // MARK: - Segue Management
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationViewController = segue.destination as? CallCenterViewController {
            if let indexPath = tableView.indexPathForSelectedRow {
                destinationViewController.leads = [leads[indexPath.row]]
            }
        }
    }
    
}

extension CallCenterViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sample.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.Cells.sampleSample, for: indexPath)
        
        let sample = sample[indexPath.row]
        cell.detailTextLabel?.text = sample.sampleId
        
        if let example = sample.sampleSample.first {
            cell.textLabel?.text = sample.sampleName
        }
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
