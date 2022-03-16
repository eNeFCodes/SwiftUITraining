//
//  AppEnvironment.swift
//  SwiftUITraining
//
//  Created by Neil Francis Hipona on 3/15/22.
//

import Foundation
import SwiftUI

enum LoginType {
    case `default`
    case atlas
    case faceAndTouchID
}

class AppEnv: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var loginType: LoginType = .default
    @Published var showingToast: Bool = false
    @Published var toastModel: ToastModel = ToastModel(title: "Toast",
                                                               message: "Message",
                                                               icon: Image(systemName: "gear"))
}

class UserSettings: ObservableObject {
    @Published var welcomeTitle: String = "WELCOME"
    @Published var welcomeMessage: String = "Please select how you wish to log in:"
}
