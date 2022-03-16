//
//  LoginWelcomeView.swift
//  SwiftUITraining
//
//  Created by Neil Francis Hipona on 3/7/22.
//

import SwiftUI

struct LoginWelcomeView: View {
    @EnvironmentObject private var uSettings: UserSettings

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            let subTitleFont = Font.custom("FancyCutProB7-ThinItalic", size: 20)
            Text(uSettings.welcomeTitle)
                .font(.headline)
            Text(uSettings.welcomeMessage)
                .font(subTitleFont)
        }
        .padding(20)
        .foregroundColor(.white)
        .padding(.top, 200)
    }
}

struct LoginWelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            LoginWelcomeView()
        }
    }
}
