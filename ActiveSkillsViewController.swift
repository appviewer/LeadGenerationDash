//
//  SkillsViewController.swift
//  Josh
//
//  Created by Joshua Davis on 12/7/17.
//  Copyright © 2017 Joshua Davis. All rights reserved.
//

import UIKit

class ActiveSkillsViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    var something = [Something]()
    
    // MARK: - Private API
    fileprivate func loadData() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        // Grab skills
        RESTManager.shared.getSomething(completion: { (status, response) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            if let response = response as? JSONArray {
                for json in response {
                    self.something.append(Something(with: json))
                }
            }
        })
    }
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
    }
    
    // MARK: - Segue Management
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationViewController = segue.destination as? CallCenterViewController {
            
        }
    }
    
}

extension ActiveSkillsViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return something.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.Cells.skill, for: indexPath)
        
        let something = something[indexPath.row]
        cell.textLabel?.text = something.name
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
