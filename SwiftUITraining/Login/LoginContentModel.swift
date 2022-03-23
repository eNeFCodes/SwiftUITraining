//
//  LoginContentModel.swift
//  SwiftUITraining
//
//  Created by Neil Francis Hipona on 3/17/22.
//

import Combine
import SwiftUI

class LoginContentModel: ObservableObject {

    private var subscriptions = Set<AnyCancellable>()
    private var loginPublisher = PassthroughSubject<Void, Never>()

    let atlasLoginTitle: LocalizedStringKey = "ATLAS LOGIN"
    let faceTouchIDTitle: LocalizedStringKey = "FACE/TOUCH ID LOGIN"

    private var username: String = ""
}

extension LoginContentModel {

    private func networkRequest() -> AnyPublisher<Bool, Never> {

        // fetch from keychain
        username = "test_user"

        return URLSession.shared
            .dataTaskPublisher(for: URL(string: "https://source.unsplash.com/random")!)
            .map { data, _ in !data.isEmpty }
            .print("networkRequest")
            .replaceError(with: false)
            .eraseToAnyPublisher()
    }

    private func processLogin(callback: @escaping (_ isLoggedIn: Bool) -> Void) {
        loginPublisher
            .map { self.networkRequest() }
            .switchToLatest()
            .sink { status in
                DispatchQueue.main.async {
                    callback(status)
                }
            }
            .store(in: &subscriptions)
        loginPublisher.send()
    }

    func faceAndTouchIDLogin(completion: @escaping (Biometrics.LoginAuthStatus) -> Void) {
        Biometrics.triggerBiometrics { [weak self] status in
            guard let self = self else { return }

            switch status {
            case .authenticated:
                completion(.loggingIn)
                self.processLogin { status in
                    if status {
                        completion(.authenticated(user: User(username: self.username)))
                    } else {
                        let error = NSError(domain: "error.Biometrics.auth", code: 999, userInfo: ["message": "Authentication failed."])
                        completion(.failed(error: error))
                    }
                }

            case .failed(let error as NSError):
                completion(.failed(error: error))
            }
        }
    }
}
