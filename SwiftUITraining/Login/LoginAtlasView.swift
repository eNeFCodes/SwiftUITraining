//
//  LoginAtlasView.swift
//  SwiftUITraining
//
//  Created by Neil Francis Hipona on 3/16/22.
//

import SwiftUI

private struct AlertItem: Identifiable {
    var id: String
    var title: String
    var message: String
}

struct LoginAtlasView: View {

    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var appEnv: AppEnv
    @StateObject private var model = LoginModel()

    var body: some View {
        ZStack(alignment: .trailing) {
            GeometryReader { geometry in
                let frameHeight = geometry.size.height * 0.6
                let frameWidth = geometry.size.width * 0.75

                HStack {
                    Spacer()
                    Image("img_bg_login")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: frameWidth,
                               height: frameHeight,
                               alignment: .trailing)
                }
                .ignoresSafeArea()

                VStack(alignment: .leading) {
                    LoginHeaderView(geometry: geometry)
                        .padding(.top, 50)
                    LoginWelcomeView()
                    LoginAtlasInputView(model: model)
                }
                .ignoresSafeArea()
            }
        }
        .background(Color.black)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Image("ic_back")
        }))
    }
}

struct LoginAtlasView_Previews: PreviewProvider {
    static var previews: some View {
        LoginAtlasView()
    }
}
