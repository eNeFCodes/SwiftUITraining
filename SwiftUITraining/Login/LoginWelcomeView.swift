//
//  LoginWelcomeView.swift
//  SwiftUITraining
//
//  Created by Neil Francis Hipona on 3/7/22.
//

import SwiftUI

struct LoginWelcomeView: View {
    var title: String = "WELCOME"
    var subTitle: String = "Please select how you wish to log in:"
    var geometry: GeometryProxy
    var atlasLogin: () -> Void
    var faceAndTouchIDLogin: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(alignment: .leading, spacing: 20) {
                let subTitleFont = Font.custom("FancyCutProB7-ThinItalic", size: 20)
                Text(title)
                    .font(.headline)
                Text(subTitle)
                    .font(subTitleFont)
            }
            .padding(.bottom, 40)

            VStack(spacing: 20) {
                Button("ATLAS LOGIN") {
                    atlasLogin()
                }
                .frame(width: abs(geometry.size.width - 40),
                       height: 56)
                .background(Color.red)

                Button("FACE/TOUCH ID LOGIN") {
                    faceAndTouchIDLogin()
                }
                .frame(width: abs(geometry.size.width - 40),
                       height: 56)
                .background(Color.red)
            }
            .font(.headline)
        }
        .foregroundColor(.white)
        .padding(20)
        .frame(height: 290)
        .padding(.bottom, 100)
    }
}

struct LoginWelcomeView_Previews: PreviewProvider {
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
