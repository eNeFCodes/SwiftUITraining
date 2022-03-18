//
//  LoginContentView.swift
//  SwiftUITraining
//
//  Created by Neil Francis Hipona on 3/7/22.
//

import SwiftUI

struct LoginContentView: View {

    @EnvironmentObject private var appEnv: AppEnv
    @StateObject private var model = LoginContentModel()

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
                    LoginButtonView(model: model)

                    Group {
                        NavigationLink("", isActive: $model.isLoginModeAtlas) {
                            LoginAtlasView()
                        }
                        if !model.isLoginModeAtlas {
                            NavigationLink("", isActive: $appEnv.isLoggedIn) {
                                FTUEContentView()
                            }
                        }
                    }
                }
                .ignoresSafeArea()
            }
        }
        .background(Color.black)
    }
}

struct LoginContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginContentView()
    }
}
