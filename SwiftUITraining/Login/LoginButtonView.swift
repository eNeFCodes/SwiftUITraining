//
//  LoginButtonView.swift
//  SwiftUITraining
//
//  Created by Neil Francis Hipona on 3/16/22.
//

import SwiftUI

struct LoginButtonView: View {

    @EnvironmentObject private var appEnv: AppEnv
    @ObservedObject var model: LoginContentModel

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 20) {
                Button {
                    appEnv.loginMode = .atlas
                } label: {
                    Text(model.atlasLoginTitle)
                        .accessibilityLabel(model.atlasLoginTitle)
                        .frame(width: abs(geometry.size.width),
                               height: 56)
                }
                .background(Color.red)

                Button {
                    model.faceAndTouchIDLogin { status in
                        switch status {
                        case .loggingIn:
                            appEnv.showingToast = false
                            appEnv.isLoading = true

                        case .authenticated:
                            appEnv.showingToast = false
                            appEnv.isLoading = false
                            appEnv.isLoggedIn = true
                            appEnv.user = User(username: "")

                        case .failed(let error as NSError):
                            let message: String = (error.userInfo["message"] as? String) ?? error.localizedDescription
                            appEnv.showingToast = true
                            appEnv.toastModel = .init(title: "Error", message: message, icon: .init(systemName: "gear"))
                        }
                    }
                } label: {
                    Text(model.faceTouchIDTitle)
                        .accessibilityLabel(model.faceTouchIDTitle)
                        .frame(width: abs(geometry.size.width),
                               height: 56)
                }
                .background(Color.red)
                
            }
            .font(.headline)
            .foregroundColor(.white)
        }
        .padding(20)
        .padding(.top, 40)
    }
}
