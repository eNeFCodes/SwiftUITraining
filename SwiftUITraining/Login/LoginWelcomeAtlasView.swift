//
//  LoginWelcomeAtlasView.swift
//  SwiftUITraining
//
//  Created by Neil Francis Hipona on 3/8/22.
//

import SwiftUI

struct LoginWelcomeAtlasView: View {
    var title: String = "WELCOME"
    var subTitle: String = "Please select how you wish to log in:"
    var geometry: GeometryProxy
    var loginAction: (_ username: String, _ password: String) -> Void

    @State var username: String = ""
    @State var password: String = ""

    private var canProceed: Bool {
        !username.isEmpty && !password.isEmpty
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(alignment: .leading, spacing: 20) {
                Text(title)
                    .font(.headline)
                Text(subTitle)
                    .font(.subheadline)
            }
            .padding(.bottom, 20)

            VStack(spacing: 20) {
                ZStack(alignment: .leading) {
                    if username.isEmpty {
                        Text("EMAIL",
                             comment: "Enter your registered username here")
                            .foregroundColor(.white)
                    }

                    TextField("",
                              text: $username)
                        .frame(height: 56,
                               alignment: .leading)
                }
                .frame(height: 56,
                       alignment: .leading)

                ZStack(alignment: .leading) {
                    if password.isEmpty {
                        Text("PASSWORD",
                             comment: "Enter your registered password here")
                            .foregroundColor(.white)
                    }

                    SecureField("",
                                text: $password)
                        .frame(height: 56,
                               alignment: .leading)
                }
                .padding(.bottom, 60)

                Button("LOG IN") {
                    loginAction(username, password)
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
        .padding(.bottom, 40)
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
