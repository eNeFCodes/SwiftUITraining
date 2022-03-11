//
//  LoginContentView.swift
//  SwiftUITraining
//
//  Created by Neil Francis Hipona on 3/7/22.
//

import SwiftUI

private enum LoginType {
    case `default`
    case atlas
    case faceAndTouchID
}

struct LoginContentView: View {
    @State private var isLoading: Bool = false
    @State private var loginType: LoginType = .default

    var body: some View {
        LoaderView(content: { geometry in
            ZStack(alignment: .trailing) {
                let frameHeight = geometry.size.height * 0.6
                let frameWidth = geometry.size.width * 0.75

                VStack {
                    Image("img_bg_login")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .ignoresSafeArea()
                        .frame(width: frameWidth,
                               height: frameHeight,
                               alignment: .trailing)
                    Spacer()
                }
                
                VStack(alignment: .leading) {
                    LoginHeaderView(geometry: geometry)
                    Spacer(minLength: 60)

                    switch loginType {
                    case .atlas:
                        LoginWelcomeAtlasView(geometry: geometry,
                                              loginAction: loginAction)
                    default:
                        LoginWelcomeView(geometry: geometry,
                                         atlasLogin: atlasLogin,
                                         faceAndTouchIDLogin: faceAndTouchIDLogin)
                    }
                }
            }
            .background(Color.black)
        }, isLoading: $isLoading)
    }

    private func atlasLogin() {
        print("atlasLogin")
        loginType = .atlas
    }

    private func faceAndTouchIDLogin() {
        print("faceAndTouchIDLogin")
        loginType = .faceAndTouchID

        Biometrics.triggerBiometrics { status in
            switch status {
            case .authenticated:
                print("Biometrics status: \(status)")

            case .failed(let error):
                showAlert(with: error)
            }
        }
    }

    private func loginAction(username: String, password: String) {
        print("loginAction uname: \(username) -- pwd: \(password)")
        isLoading = true

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            isLoading = false
        }
    }

    private func showAlert(with error: Error) {

    }
}

struct LoginContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginContentView()
    }
}
