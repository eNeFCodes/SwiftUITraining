//
//  LoginAtlasInputView.swift
//  SwiftUITraining
//
//  Created by Neil Francis Hipona on 3/8/22.
//

import SwiftUI

struct LoginAtlasInputView: View {

    @EnvironmentObject private var appEnv: AppEnv
    @EnvironmentObject private var uSettings: UserSettings
    @ObservedObject var model: LoginModel

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 20) {
                ZStack(alignment: .leading) {
                    if model.username.isEmpty {
                        Text(model.emailFieldTitle, comment: "Enter your registered username here")
                            .accessibility(hidden: true)
                            .foregroundColor(.white)
                    }

                    TextField("", text: $model.username)
                        .accessibilityLabel(model.emailFieldTitle)
                        .frame(height: 56,
                               alignment: .leading)
                        .foregroundColor(.white)
                }
                .padding(.bottom, 20)

                ZStack(alignment: .leading) {
                    if model.password.isEmpty {
                        Text(model.pwdFieldTitle, comment: "Enter your registered password here")
                            .accessibility(hidden: true)
                            .foregroundColor(.white)
                    }

                    SecureField("", text: $model.password)
                        .accessibilityLabel(model.pwdFieldTitle)
                        .frame(height: 56,
                               alignment: .leading)
                        .foregroundColor(.white)
                }
                Spacer()

                Button(model.loginBtnTitle) {
                    appEnv.isLoading = true
                    model.processLogin { isLoggedIn in
                        appEnv.isLoading = false
                        appEnv.isLoggedIn = true
                    }
                }
                .accessibilityLabel(model.loginBtnTitle)
                .frame(width: abs(geometry.size.width - 40),
                       height: 60,
                       alignment: .center)
                .border(.gray, width: 1)
                .foregroundColor(model.canProceed ? .white : .gray)
                .disabled(!model.canProceed)
                .padding(.bottom, 40)
            }
            .font(.headline)
            .padding(20)
        }
    }
}
