//
//  LoginAtlasInputView.swift
//  SwiftUITraining
//
//  Created by Neil Francis Hipona on 3/8/22.
//

import SwiftUI

struct LoginAtlasInputView: View {

    @EnvironmentObject private var uSettings: UserSettings
    @ObservedObject var model: LoginModel

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 20) {
                ZStack(alignment: .leading) {
                    if model.username.isEmpty {
                        Text("EMAIL", comment: "Enter your registered username here")
                            .accessibility(hidden: true)
                            .foregroundColor(.white)
                    }

                    TextField("", text: $model.username)
                        .accessibilityLabel("EMAIL")
                        .frame(height: 56,
                               alignment: .leading)
                        .foregroundColor(.white)
                }
                .padding(.bottom, 20)

                ZStack(alignment: .leading) {
                    if model.password.isEmpty {
                        Text("PASSWORD", comment: "Enter your registered password here")
                            .accessibility(hidden: true)
                            .foregroundColor(.white)
                    }

                    SecureField("", text: $model.password)
                        .accessibilityLabel("PASSWORD")
                        .frame(height: 56,
                               alignment: .leading)
                        .foregroundColor(.white)
                }
                Spacer()

                let loginString = "LOG IN"
                Button(loginString) {

                }
                .accessibilityLabel(loginString)
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
