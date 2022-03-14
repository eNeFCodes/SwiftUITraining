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

private struct AlertItem: Identifiable {
    var id: String
    var title: String
    var message: String
}

struct LoginContentView: View {

    @State private var isLoading: Bool = false
    @State private var loginType: LoginType = .default
    @State private var showAlert: Bool = false
    @State private var alertItem: AlertItem?
    @State private var isLoggedIn: Bool = false

    var body: some View {
        LoaderView(content: { geometry in
            ZStack(alignment: .trailing) {
                let frameHeight = geometry.size.height * 0.6
                let frameWidth = geometry.size.width * 0.75

                VStack {
                    Image("img_bg_login")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: frameWidth,
                               height: frameHeight,
                               alignment: .trailing)
                    Spacer()
                }
                .ignoresSafeArea()
                
                VStack(alignment: .leading) {
                    LoginHeaderView(geometry: geometry)
                    Spacer(minLength: 60)

                    switch loginType {
                    case .atlas:
                        LoginWelcomeAtlasView(model: .init(),
                                              geometry: geometry,
                                              loginAction: loginAction)
                        if isLoggedIn {
                            NavigationLink("", isActive: $isLoggedIn) {
                                HomeView()
                            }
                            .navigationTitle("HOME NAVIGATION")
                            .foregroundColor(.white)
                        }
                    default:
                        LoginWelcomeView(geometry: geometry,
                                         atlasLogin: atlasLogin,
                                         faceAndTouchIDLogin: faceAndTouchIDLogin)
                    }
                }
                .ignoresSafeArea()
                .padding(.bottom, 40)
            }
            .background(Color.black)
        }, isLoading: $isLoading)
            .alert(Text(alertItem?.title ?? ""),
                   isPresented: $showAlert,
                   presenting: alertItem,
                   actions: { item in
                Button("OK") {
                    loginType = .default
                }
            }, message: { item in
                Text(item.message)
            })
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
                alertItem = nil
                print("Biometrics status: \(status)")

            case .failed(let error):
                showAlert = true
                alertItem = .init(id: "1", title: "Error", message: error.localizedDescription)
            }
        }
    }

    private func loginAction(username: String, password: String) {
        print("loginAction uname: \(username) -- pwd: \(password)")
        isLoading = true

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            isLoading = false
            isLoggedIn = true
        }
    }
}

struct LoginContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginContentView()
    }
}
