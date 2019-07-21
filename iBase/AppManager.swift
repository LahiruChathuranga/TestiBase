//
//  AppManager.swift
//  iBase
//
//  Created by Lahiru Chathuranga on 6/20/19.
//  Copyright © 2019 ElegantMedia. All rights reserved.
//

import Foundation
class ApplicationManager: NSObject {
    
    static let shared = ApplicationManager()
    
    let bundleId = Bundle.main.bundleIdentifier ?? ""
    let deviceId = UIDevice.current.identifierForVendor!.uuidString
    let deviceType = "APPLE"
    
    override init() {
        super.init()
        
    }
    
}
