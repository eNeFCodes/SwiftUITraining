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

    var canProceed: Bool {
        !username.isEmpty && !password.isEmpty
    }
}
