//
//  LoginModel.swift
//  SwiftUITraining
//
//  Created by Neil Francis Hipona on 3/11/22.
//

import Foundation
import SwiftUI

class LoginModel: ObservableObject {

    @Published var username: String = ""
    @Published var password: String = ""

    let emailFieldTitle: LocalizedStringKey = "EMAIL"
    let pwdFieldTitle: LocalizedStringKey = "PASSWORD"
    let loginBtnTitle: LocalizedStringKey = "LOG IN"

    var canProceed: Bool {
        !username.isEmpty && !password.isEmpty
    }

    func processLogin(callback: (_ isLoggedIn: Bool) -> Void) {
        
        
    }
}
