//
//  LoginView_OLD.swift
//  SwiftUITraining
//
//  Created by Neil Francis Hipona on 3/7/22.
//

import SwiftUI

struct LoginView_OLD: View {
    @State var username: String = ""
    @State var password: String = ""
    @State var isLoading: Bool = false
    @State var errorMessage: String = "Invalid Username and/or Password"
    @State var hasError: Bool = false

    var body: some View {
        LoaderView(content: { geometry in 
            VStack {
                Text("CNT Jewelry")
                    .font(.headline)
                    .foregroundColor(.blue)
                    .padding()

                Image("ic_logo")
                    .clipShape(Circle())
                    .overlay {
                        Circle().stroke(.red, lineWidth: 4)
                    }
                    .shadow(radius: 7)

                Form {
                    TextField("Enter your registered username here",
                              text: $username,
                              prompt: Text("Username"))
                        .multilineTextAlignment(.center)
                        .padding()

                    SecureField("Enter your registered password here",
                                text: $password,
                                prompt: Text("Password"))
                        .multilineTextAlignment(.center)
                        .padding()

                    HStack(alignment: .center) {
                        Spacer()
                        Text(errorMessage)
                            .font(.footnote)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                            .opacity(hasError ? 1 : 0)
                        Spacer()
                    }
                }

                Button("Log In") {
                    if !username.isEmpty && !password.isEmpty {
                        processLogin()
                    } else {
                        hasError = true
                    }
                }
                .font(.headline)
                .padding()
            }
        }, isLoading: $isLoading)
    }

    private func processLogin() {
        print("uname: \(username) -- pwd: \(password)")
        isLoading = true
        hasError = false

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            isLoading = false
            hasError = Int.random(in: 0..<1) == 1
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView_OLD()
    }
}
