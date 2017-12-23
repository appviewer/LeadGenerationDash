//
//  Constants.swift
//  Josh
//
//  Created by Joshua Davis on 11/10/17.
//  Copyright © 2017 Joshua Davis. All rights reserved.
//

import UIKit

let IS_LOGGED_IN = "IS_LOGGED_IN"
let API_URL = ""
let KEY = ""

struct Storyboards {
    static let main = "Main"
}

struct Credentials {
    static let Credentials = "**********"
}

struct Identifiers {
    static let identifier = "IdentifierViewController"
    static let identifier = "IdentifierViewController"
    
    struct Cells {
        static let cell = "cell"
        static let cellCell = "cellCell"
        static let cell = "cell"
        static let cell = "cell"
    }
}

struct Actions {
    static let action = "action"
    static let action = "action"
}

struct Endpoints {
    static let leads = "\(API_URL)?API_Action=\(Actions.action)&Key=\(KEY)&Format=JSON&Example_Type=00&Early_BIRD_Special=11111"
    static let login = "https://app.sample.com/example/ex/cont/and/done"
    static let reports = "\(API_URL)?API_Action=\(Actions.action)&Key=\(KEY)&Format=JSON&Early_BIRD_Special=11"
    static let calls = "\(API_URL)?API_Action=\(Actions.action)&Key=\(KEY)&Format=JSON&/early/1111/BIRD/special"
}

struct Segues {
    static let sampleDetails = "SampleDetailsSegue"
    static let sampleDetails = "SampleDetailsSegue"
}
