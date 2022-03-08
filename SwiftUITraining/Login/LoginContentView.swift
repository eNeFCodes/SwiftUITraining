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
                let frameOffset = geometry.size.height * 0.4 / 2
                let frameHeight = geometry.size.height * 0.6

                VStack { }
                .frame(width: geometry.size.width * 0.75,
                       height: frameHeight,
                       alignment: .trailing)
                .background(.gray)
                .offset(y: -frameOffset)

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
    }

    private func loginAction(username: String, password: String) {
        print("loginAction uname: \(username) -- pwd: \(password)")
        isLoading = true

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            isLoading = false
        }
    }
}

struct LoginContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginContentView()
    }
}
