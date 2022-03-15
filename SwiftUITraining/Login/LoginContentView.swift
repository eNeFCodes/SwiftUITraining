//
//  LoginContentView.swift
//  SwiftUITraining
//
//  Created by Neil Francis Hipona on 3/7/22.
//

import SwiftUI

private struct AlertItem: Identifiable {
    var id: String
    var title: String
    var message: String
}

struct LoginContentView: View {

    @State private var isLoading: Bool = false
    @State private var showAlert: Bool = false
    @State private var alertItem: AlertItem?
    @EnvironmentObject private var appEnv: AppEnv

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

                    switch appEnv.loginType {
                    case .atlas:
                        LoginWelcomeAtlasView(model: .init(),
                                              geometry: geometry,
                                              loginAction: loginAction)
                    default:
                        LoginWelcomeView(geometry: geometry,
                                         atlasLogin: atlasLogin,
                                         faceAndTouchIDLogin: faceAndTouchIDLogin)
                    }

                    NavigationLink("", isActive: $appEnv.isLoggedIn) {
                        HomeView()
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
                    appEnv.loginType = .default
                    appEnv.isLoggedIn = item.id == "1"
                }
            }, message: { item in
                Text(item.message)
            })
    }

    private func atlasLogin() {
        print("atlasLogin")
        appEnv.loginType = .atlas
        appEnv.showingToast = false
    }

    private func faceAndTouchIDLogin() {
        print("faceAndTouchIDLogin")
        appEnv.loginType = .faceAndTouchID

        Biometrics.triggerBiometrics { status in
            switch status {
            case .authenticated:
                print("Biometrics status: \(status)")
                showAlert = true
                alertItem = .init(id: "1", title: "Biometrics", message: "You have successfully logged in.")

            case .failed(let error):
                appEnv.showingToast = true
                appEnv.toastModel = .init(title: "Error", message: error.localizedDescription, icon: .init(systemName: "error"))
            }
        }
    }

    private func loginAction(username: String, password: String) {
        print("loginAction uname: \(username) -- pwd: \(password)")
        isLoading = true

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            isLoading = false
            appEnv.isLoggedIn = true
        }
    }
}

struct LoginContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginContentView()
    }
}
