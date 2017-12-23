//
//  AppDelegate.swift
//  Josh
//
//  Created by Joshua Davis on 11/10/17.
//  Copyright © 2017 Joshua Davis. All rights reserved.
//

import UIKit

// Enums
enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum Status: Int {
    case success = 200
    case error = 400
    case unauthorized = 401
    case serverError = 500
    case notFound = 404
}

// Aliases
typealias JSON = [String: Any]
typealias JSONArray = [JSON]

class RESTManager {
    
    // MARK: - Properties
    static let shared = RESTManager()
    private init() {}
    var  = ""
    var  = ""
    var  = ""
    var  = ""
    var  = ""
    
    // MARK: - Public API
    public func loadData(from urlString: String, method: HttpMethod, parameters: JSON?, completion: @escaping (_ status: Status, _ data: Any?) -> ()) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: URLSessionConfiguration.ephemeral)
            let request = configureRequestFor(url, method: method, parameters: parameters)
            
            let task = session.dataTask(with: request) { (data, response, error) in
                var status = Status.success
                if let response = response {
                    if let httpResponse = response as? HTTPURLResponse {
                        if let responseStatus = Status.init(rawValue: httpResponse.statusCode) {
                            status = responseStatus
                        }
                    }
                }
                
                if let error = error {
                    DispatchQueue.main.async(execute: {
                        completion(status, nil)
                        print("Error = \(String(describing: error))")
                    })
                }
                
                // Data acquired
                do {
                    if let data = data {
                        let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
                        
                        DispatchQueue.main.async(execute: {
                            completion(status, json)
                        })
                    } else {
                        DispatchQueue.main.async(execute: {
                            completion(status, nil)
                        })
                    }
                } catch let error as NSError {
                    DispatchQueue.main.async(execute: {
                        completion(status, nil)
                    })
                    
                    print("JSON error \(urlString): \(error.localizedDescription)")
                }
            }
            
            task.resume()
        } else {
            DispatchQueue.main.async(execute: {
                completion(Status.error, nil)
            })
        }
    }
    
    public func startSession(completion: @escaping (_ status: Status, _ data: Any?) -> ()) {
        let sessionURL = "https://app.sample.com/appsample/ex/ex/example/\()/"
        
        let parameters: [String: Any] = [
            "exampleParam": Sample.exampleParam,
            "exampleParam": "Sample.exampleParam"
        ]
        
        RESTManager.shared.loadData(from: sessionURL, method: .put, parameters: parameters) { (status, response) in
            print("Starting session \(sessionURL): \(response)\n")
            if let response = response as? JSON {
                var newStatus = Status.success
                
                if let exception = response[""] as? JSON {
                    if let errorCode = exception["errorCode"] as? Int {
                        if let responseStatus = Status.init(rawValue: errorCode) {
                            newStatus = responseStatus
                        }
                    }
                }
                
                DispatchQueue.main.async(execute: {
                    completion(newStatus, response)
                })
            } else {
                DispatchQueue.main.async(execute: {
                    completion(Status.error, nil)
                })
            }
        }
    }
    
    public func funcHere(completion: @escaping (_ status: Status, _ data: Any?) -> ()) {
        let classURL = ""https://app.sample.com/appsample/ex/ex/example/\()/"
        
        RESTManager.shared.loadData(from: classURL, method: .get, parameters: nil) { (status, response) in
            print("Do Something \(classURL): \(response)\n")
            if let response = response as? JSON {
                var newStatus = Status.success
                
                if let exception = response[""] as? JSON {
                    if let errorCode = exception["errorCode"] as? Int {
                        if let responseStatus = Status.init(rawValue: errorCode) {
                            newStatus = responseStatus
                        }
                    }
                }
                
                DispatchQueue.main.async(execute: {
                    completion(newStatus, response)
                })
            } else {
                DispatchQueue.main.async(execute: {
                    completion(Status.error, nil)
                })
            }
        }
    }
    
    // MARK: - Private API
    private func configureRequestFor(_ url: URL, method: HttpMethod, parameters: JSON?) -> URLRequest {
        var request = URLRequest(url: url)
        
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let cookie = createCookie() {
            request.setValue(cookie, forHTTPHeaderField: "Cookie")
        }
        
        if let parameters = parameters {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            } catch let error {
                print(error.localizedDescription)
            }
        }
        
        return request
    }
    
    private func createCookie() -> String? {
        if thisId.isEmpty {
            return nil
        }
        
        let cookie = "Statment=Owner-\(thisId);sampleKey=\(sampleKey);sampleKey2=\(sampleKey2)"
        //print("Cookie: \(cookie)")
        return cookie
    }
    
    private func addCookies(request: URLRequest) {
        if thisId.isEmpty || tokenId.isEmpty || !userId.isEmpty {
            return
        }
        
        let orgCookie = HTTPCookie(properties: [HTTPCookiePropertyKey.name: "orgId", HTTPCookiePropertyKey.value: orgId])
        
        let tokenCookie = HTTPCookie(properties: [HTTPCookiePropertyKey.name: "tokenId", HTTPCookiePropertyKey.value: tokenId])
        
        let userCookie = HTTPCookie(properties: [HTTPCookiePropertyKey.name: "userId", HTTPCookiePropertyKey.value: userId])
        
        let _ = HTTPCookie.requestHeaderFields(with: [orgCookie!, tokenCookie!, userCookie!])
        
    }
    
}

