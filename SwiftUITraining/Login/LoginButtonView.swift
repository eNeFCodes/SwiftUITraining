//
//  LoginButtonView.swift
//  SwiftUITraining
//
//  Created by Neil Francis Hipona on 3/16/22.
//

import SwiftUI

struct LoginButtonView: View {

    @EnvironmentObject private var appEnv: AppEnv
    @EnvironmentObject private var uSettings: UserSettings
    @Binding var isLoginModeAtlast: Bool

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 20) {
                let atlasLogin = "ATLAS LOGIN"
                Button(atlasLogin) {
                    isLoginModeAtlast = true
                }
                .accessibilityLabel(atlasLogin)
                .frame(width: abs(geometry.size.width),
                       height: 56)
                .background(Color.red)

                let touchIDLogin = "FACE/TOUCH ID LOGIN"
                Button(touchIDLogin) {
                    faceAndTouchIDLogin()
                }
                .accessibilityLabel(touchIDLogin)
                .frame(width: abs(geometry.size.width),
                       height: 56)
                .background(Color.red)
            }
            .font(.headline)
            .foregroundColor(.white)
        }
        .padding(20)
        .padding(.top, 40)
    }

    private func faceAndTouchIDLogin() {
//        appEnv.showingToast = false

//        Biometrics.triggerBiometrics { status in
//            switch status {
//            case .authenticated:
//                print("Biometrics status: \(status)")
//                showAlert = true
//                alertItem = .init(id: "1", title: "Biometrics", message: "You have successfully logged in.")
//
//            case .failed(let error as NSError):
//                appEnv.showingToast = true
//                let message: String = (error.userInfo["message"] as? String) ?? error.localizedDescription
//                appEnv.toastModel = .init(title: "Error", message: message, icon: .init(systemName: "warning"))
//            }
//        }
    }

    private func loginAction(username: String, password: String) {
        print("loginAction uname: \(username) -- pwd: \(password)")
//        isLoading = true
//
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
//            isLoading = false
//            appEnv.isLoggedIn = true
//        }
    }
}
