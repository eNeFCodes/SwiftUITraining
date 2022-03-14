//
//  LoginWelcomeAtlasView.swift
//  SwiftUITraining
//
//  Created by Neil Francis Hipona on 3/8/22.
//

import SwiftUI

struct LoginWelcomeAtlasView: View {

    @State var model: LoginModel
    var geometry: GeometryProxy
    var loginAction: (_ username: String, _ password: String) -> Void

    private var canProceed: Bool {
        !model.username.isEmpty && !model.password.isEmpty
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(alignment: .leading, spacing: 20) {
                Text(model.title)
                    .font(.headline)
                Text(model.subTitle)
                    .font(.subheadline)
            }
            .padding(.bottom, 20)

            VStack(spacing: 20) {
                ZStack(alignment: .leading) {
                    if model.username.isEmpty {
                        Text("EMAIL",
                             comment: "Enter your registered username here")
                            .foregroundColor(.white)
                    }

                    TextField("",
                              text: $model.username)
                        .frame(height: 56,
                               alignment: .leading)
                }
                .frame(height: 56,
                       alignment: .leading)

                ZStack(alignment: .leading) {
                    if model.password.isEmpty {
                        Text("PASSWORD",
                             comment: "Enter your registered password here")
                            .foregroundColor(.white)
                    }

                    SecureField("",
                                text: $model.password)
                        .frame(height: 56,
                               alignment: .leading)
                }
                .padding(.bottom, 60)

                Button("LOG IN") {
                    loginAction(model.username, model.password)
                }
                .frame(width: geometry.size.width - 40,
                       height: 56)
                .border(.gray, width: 1)
                .foregroundColor(canProceed ? .white : .gray)
                .disabled(!canProceed)
            }
            .font(.headline)
        }
        .foregroundColor(.white)
        .padding(20)
        .frame(height: 290)
    }
}

struct LoginWelcomeInputView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            LoginWelcomeView(geometry: geometry) {
                print("atlasLogin")
            } faceAndTouchIDLogin: {
                print("faceAndTouchIDLogin")
            }
        }
    }
}
