//
//  AppEnvironment.swift
//  SwiftUITraining
//
//  Created by Neil Francis Hipona on 3/15/22.
//

import Foundation
import SwiftUI

class AppEnv: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var isLoggedIn: Bool = false
    @Published var showingToast: Bool = false
    @Published var toastModel: ToastModel = ToastModel(title: "Toast",
                                                               message: "Message",
                                                               icon: Image(systemName: "gear"))
    @Published var user: User = .init(username: "NO USER")
}

class UserSettings: ObservableObject {
    @Published var appName: String = "CNT\nJEWERLY"
    @Published var welcomeTitle: String = "WELCOME"
    @Published var welcomeMessage: String = "Please select how you wish to log in:"
}
