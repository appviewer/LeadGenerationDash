//
//  ViewController.swift
//  Josh
//
//  Created by Joshua Davis on 11/10/17.
//  Copyright © 2017 Joshua Davis. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: - Actions
    @IBAction func submitButtonTapped() {
        guard let username = usernameTextField.text, let password = passwordTextField.text else {
            return
        }
        
        let parameters: [String: Any] = [
            "passwordCredentials" : [
                "username": username,
                "password": password
            ],
            "policy": ""
        ]
        
        RESTManager.shared.loadData(from: Endpoints.login, method: .post, parameters: parameters) { [weak self] (status, response) in
            
            if let response = response as? JSON {
                //print(response)
                self?.parse(response)
                
                // Start Session
                RESTManager.shared.startSession(completion: { [weak self] (status, response) in
                    if let response = response as? JSON {
                        if let exception = response["exceptionDetail"] as? JSON {
                            if let message = exception["message"] as? String {
                                self?.presentAlert("Error", message: message)
                            }
                        }
                    } else {
                        self?.showTabBar()
                    }
                })
            }
        }
    }
    
    // MARK: - Private API
    fileprivate func showTabBar() {
        let storyboard = UIStoryboard(name: Storyboards.main, bundle: Bundle.main)
        let tabBarController = storyboard.instantiateViewController(withIdentifier: Identifiers.tabBar)
        
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            delegate.window?.rootViewController = tabBarController
        }
    }
    
    fileprivate func parse(_ response: JSON) {
        guard let privateId = response["privateId"] as? String, let closeId = response["closeId"] as? String, let privateId = response["privateId"] as? String else {
            fatalError("You did not logged in successfully")
        }
        
        print("\nPrivate ID: \(privateId)")
        RESTManager.shared.privateId = privateId
        
        print("Close ID: \(closeId)")
        RESTManager.shared.closeId = closeId
        
        print("privateId: \(privateId)")
        RESTManager.shared.privateId = privateId
        
        if let metadata = response["metadata"] as? JSON {
            if let dataCenters = metadata["dataCenters"] as? JSONArray {
                if let dataCenter = dataCenters.first {
                    if let apiUrls = dataCenter["apiUrls"] as? JSONArray {
                        if let apiUrl = apiUrls.first {
                            if let hiddenKey = apiUrl["hiddenKey"] as? String {
                                print("API Hidden Key: \(hiddenKey)")
                                RESTManager.shared.apiHiddenKey = hiddenKey
                            }
                        }
                    }
                    
                    if let uiUrls = dataCenter["uiUrls"] as? JSONArray {
                        if let uiUrl = uiUrls.first {
                            if let hiddenKey = uiUrl["hiddenKey"] as? String {
                                print("UI Hidden Key: \(hiddenKey)\n")
                                RESTManager.shared.uiHiddenKey = hiddenKey
                            }
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - UIResponder
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}
