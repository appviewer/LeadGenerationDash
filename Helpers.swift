//
//  Helpers.swift
//  Josh
//
//  Created by Joshua Davis on 11/10/17.
//  Copyright © 2017 Joshua Davis. All rights reserved.
//

import UIKit

class Helpers {

    // MARK: - Public API
    static func isLoggedIn() -> Bool {
        return UserDefaults.standard.bool(forKey: IS_LOGGED_IN)
    }
    
    static func getDate(from string: String) -> Date? {
        let dateFormatter  = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return dateFormatter.date(from: string)
    }
    
    static func getDateString(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dateFormatter.string(from: date)
    }
    
}

extension UIViewController {
    
    func shareItems(_ items: [Any], onViewController viewController: UIViewController) {
        let activityController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        activityController.excludedActivityTypes = [.postToWeibo, .openInIBooks]
        viewController.present(activityController, animated: true)
    }
    
    func presentAlert(_ title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true)
    }
    
}

