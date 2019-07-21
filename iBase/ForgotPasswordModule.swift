//
//  ForgotPasswordModule.swift
//  iBase
//
//  Created by Lahiru Chathuranga on 7/21/19.
//  Copyright © 2019 ElegantMedia. All rights reserved.
//

import Foundation

public class ForgotPasswordModule: ValidatorDelegate {
     var email: String = ""
    
    //Init
    public init(email: String) {
        self.email = email
    }
    
    //OPen func to call from project
    public func ForgotPasswordRequest(completion: @escaping completionHandler) {
        validateAndRetrievePassword { (success, message) in
            if success {
                forgotPasswordNetworkRequest(completion: { (success, statusCode, message) in
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
    
    private func validateRetrievePassword() throws -> Bool {
        
        guard !(email.trim().isEmpty) else {
            throw ValidateError.invalidData("Email Required")
        }
        
        guard isValidEmailAddress(email: email) else {
            throw ValidateError.invalidData("Invalid Email")
        }
        
        return true
    }
    
    // Validate and Retrive Password
    func validateAndRetrievePassword(completion: actionHandler) {
        do {
            if try validateRetrievePassword() {
                completion(true, .Success)
            }
        } catch ValidateError.invalidData(let message) {
            completion(false, message)
        } catch {
            completion(false, .MisingData)
        }
    }

    
    //Proceed with backend
    func forgotPasswordNetworkRequest(complation: @escaping completionHandler) {
        guard Reachability.isInternetAvailable() else {
            complation(false, 503, .InternetConnectionOffline)
            return
        }
        ForgotPasswordAPI.passwordEmailPost(email: email) { (response, error) in
            if error != nil {
                if let errorResponse = error as? ErrorResponse {
                    switch errorResponse {
                    case .error(let statusCode, let data, _):
                        guard let responseData = data else {return}
                        let errorJson = JSON(responseData)
                        complation(false, statusCode, errorJson["message"].stringValue)
                    }
                }
            } else {
                guard let responseJson = response?.message else {return}
                complation(true, 200, responseJson)
            }
        }
    }
}
