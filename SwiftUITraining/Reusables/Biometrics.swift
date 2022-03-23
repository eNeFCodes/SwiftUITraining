//
//  Biometrics.swift
//  SwiftUITraining
//
//  Created by Neil Francis Hipona on 3/11/22.
//

import Foundation
import LocalAuthentication

class Biometrics {

    enum AuthStatus {
        case authenticated
        case failed(error: Error)
    }

    enum LoginAuthStatus {
        case loggingIn
        case authenticated(user: User)
        case failed(error: Error)
    }

    class func triggerBiometrics(completion: @escaping (AuthStatus) -> Void) {
        let context = LAContext()
        context.localizedReason = "Use to login to your account"
        context.localizedCancelTitle = "Use Default Login"

        var error: NSError?
        let policy: LAPolicy = .deviceOwnerAuthentication
        if context.canEvaluatePolicy(policy, error: &error) {
            context.evaluatePolicy(policy, localizedReason: "Log in using biometrics") { success, error in
                DispatchQueue.main.async {
                    if success {
                        completion(.authenticated)
                    } else {
                        let errMsg = error?.localizedDescription ?? "Can't evaluate policy"
                        let err = NSError.init(domain: "com.Biometrics.error", code: 9999, userInfo: ["message": errMsg])
                        completion(.failed(error: err))
                    }
                }
            }
        } else {
            let errMsg = error?.localizedDescription ?? "Can't evaluate policy"
            let err = NSError.init(domain: "com.Biometrics.error", code: 9999, userInfo: ["message": errMsg])
            completion(.failed(error: err))
        }
    }
}
