//
//  User.swift
//  SwiftUITraining
//
//  Created by Neil Francis Hipona on 3/18/22.
//

import Foundation

class User: ObservableObject {
    let username: String

    init(username: String) {
        self.username = username
    }
}
