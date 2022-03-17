//
//  LoginModel.swift
//  SwiftUITraining
//
//  Created by Neil Francis Hipona on 3/11/22.
//

import Combine
import SwiftUI

class LoginModel: ObservableObject {

    private var subscriptions = Set<AnyCancellable>()
    private var loginPublisher = PassthroughSubject<Void, Never>()

    @Published var username: String = ""
    @Published var password: String = ""

    let emailFieldTitle: LocalizedStringKey = "EMAIL"
    let pwdFieldTitle: LocalizedStringKey = "PASSWORD"
    let loginBtnTitle: LocalizedStringKey = "LOG IN"

    var canProceed: Bool {
        !username.isEmpty && !password.isEmpty
    }
}

extension LoginModel {

    private func networkRequest() -> AnyPublisher<Bool, Never> {
        return URLSession.shared
            .dataTaskPublisher(for: URL(string: "https://source.unsplash.com/random")!)
            .map { data, _ in !data.isEmpty }
            .print("networkRequest")
            .replaceError(with: false)
            .eraseToAnyPublisher()
    }

    func processLogin(callback: @escaping (_ isLoggedIn: Bool) -> Void) {
        loginPublisher
            .map { self.networkRequest() }
            .switchToLatest()
            .sink { success in
                DispatchQueue.main.async {
                    callback(success)
                }
            }
            .store(in: &subscriptions)
        loginPublisher.send()
    }
}
