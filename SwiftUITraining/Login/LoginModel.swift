//
//  LoginModel.swift
//  SwiftUITraining
//
//  Created by Neil Francis Hipona on 3/11/22.
//

import Foundation
import SwiftUI

struct LoginModel {
    
    var username: String = ""
    var password: String = ""

    var canProceed: Bool {
        !username.isEmpty && !password.isEmpty
    }
}
