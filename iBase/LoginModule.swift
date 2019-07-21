//
//  LoginModule.swift
//  iBase
//
//  Created by Lahiru Chathuranga on 6/20/19.
//  Copyright © 2019 ElegantMedia. All rights reserved.
//

import Foundation
import iBaseSwagger
import SwiftyJSON

public class LoginModule: ValidatorDelegate {
    
    var email: String = ""
    var password: String = ""
    
    //Init
    public init(email: String, password: String) {
        self.email = email
        self.password = password
    }
    //OPen func to call from project
    public func LoginRequest(completion: @escaping completionHandler) {
        validateAndLoginUser { (success, message) in
            if success {
                userLoginNetworkRequest(completion: { (success, statusCode, message) in
                    if success {
                        completion(true, statusCode, message)
                    } else {
                        completion(false, statusCode, message)
                    }
                })
            } else {
                completion(false, 404, message)
            }
        }
    }
    
     private func validateLogin() throws -> Bool {
        
        guard !(email.trim().isEmpty) else {
            throw ValidateError.invalidData("Email Required")
        }
        
        guard isValidEmailAddress(email: email) else {
            throw ValidateError.invalidData("Invalid Email")
        }
        
        guard !(password.isEmpty) else {
            throw ValidateError.invalidData("Password Required")
        }
        
        guard (password.count >= 6) else {
            throw ValidateError.invalidData("Invalid Password")
        }
        
        return true
    }
    
    // Validate and Login
    private func validateAndLoginUser(completion: actionHandler) {
        do {
            if try validateLogin() {
                completion(true, "Success")
            }
        } catch ValidateError.invalidData(let message) {
            completion(false, message)
        } catch {
            completion(false, "MisingData")
        }
    }
    
    //Proceed with Login
    private func userLoginNetworkRequest(completion: @escaping completionHandler) {
        guard Reachability.isInternetAvailable() else {
            completion(false, 503, "InternetConnectionOffline")
            return
        }
        AuthAPI.loginPost(deviceId: ApplicationManager.shared.deviceId, deviceType: ApplicationManager.shared.deviceType, email: email, password: password) { (response, error) in
            
            if error != nil {
                if let errorResponse = error as? ErrorResponse {
                    switch errorResponse {
                    case .error(let statusCode, let data, _):
                        guard let responseData = data else {return}
                        let errorJson = JSON(responseData)
                        completion(false, statusCode, errorJson["message"].stringValue)
                    }
                }
            } else {
//                guard let responseJson: User = response?.payload else {return}
//                SwaggerClientAPI.customHeaders.updateValue(responseJson.accessToken ?? "", forKey: "x-access-token")
                completion(true, 200, response?.message ?? "success")
            }
            
        }
    }
}
