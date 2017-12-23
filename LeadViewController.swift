//
//  LeadViewController.swift
//  Josh
//
//  Created by Joshua Davis on 11/10/17.
//  Copyright © 2017 Joshua Davis. All rights reserved.
//

import UIKit

class LeadViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    var client = [Client]()
    
    // MARK: - Private API
    fileprivate func loadData() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        RESTManager.shared.loadData(from: Endpoints.leads, method: .get, parameters: nil) { (status, response) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            if let json = client as? JSON {
                if let client = json["client"] as? JSON {
                    if let clients = response["clients"] as? JSON {
                        if let client = clients["client"] as? JSONArray {
                            for clientSON in client {
                                self.clients.append(Client(with: clientJSON))
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
        if let destinationViewController = segue.destination as? LeadDetailsViewController {
            if let indexPath = tableView.indexPathForSelectedRow {
                destinationViewController.client = clients[indexPath.row]
            }
        }
    }
    
}

extension LeadViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.Cells.cell, for: indexPath)
        
        let client = clients[indexPath.row]
        cell.detailTextLabel?.text = client.clientID
        
        if let clientGroup = client.clientGroup.first {
            cell.textLabel?.text = client.clientName
        }
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
