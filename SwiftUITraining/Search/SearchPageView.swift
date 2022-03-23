//
//  SearchPageView.swift
//  SwiftUITraining
//
//  Created by Neil Francis Hipona on 3/23/22.
//

import SwiftUI

struct SearchPageView: View {

    @EnvironmentObject private var appEnv: AppEnv
    @State private var searchTxt: String = ""

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    let hSize = CGSize(width: geometry.size.width * 0.75, height: 100)
                    HStack {
                        let font = Font.custom("FancyCutCondProB7-Bold", size: 30)
                        let titleStr = "SEARCH"

                        Text(titleStr)
                            .accessibilityLabel(titleStr)
                            .font(font)
                            .foregroundColor(.black)
                            .padding(20)
                            .frame(width: abs(hSize.width), height: hSize.height, alignment: .leading)
                            .background(Color.white)
                            .mask {
                                let curve: CGFloat = 20
                                let p1 = CGPoint(x: 0, y: 0)
                                let p2 = CGPoint(x: hSize.width, y: 0)
                                let p3 = CGPoint(x: hSize.width, y: hSize.height - curve)
                                let p4 = CGPoint(x: hSize.width - curve, y: hSize.height)
                                let p5 = CGPoint(x: 0, y: hSize.height)
                                BorderView(coordinates: [p1, p2, p3, p4, p5], shouldClosePath: true)
                            }
                    }
                    .frame(height: hSize.height, alignment: .leading)
                    Spacer()
                }
                .ignoresSafeArea()
                .frame(width: abs(geometry.size.width), alignment: .leading)

                VStack {
                    HStack {
                        Spacer()
                        Button {
                            appEnv.isLoggedIn = false
                            appEnv.loginMode = .default
                        } label: {
                            Image("ic_close_white")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50, alignment: .center)
                                .padding(20)
                        }
                    }
                    Spacer()
                }
            }
            .frame(width: abs(geometry.size.width), alignment: .center)

            VStack {
                let config = InputFieldView.Config(id: 0,
                                                   text: $searchTxt,
                                                   geometry: geometry,
                                                   showButton: true,
                                                   icon: Image("ic_search_white"),
                                                   action: triggerInputFieldAction)

                let config2 = InputFieldView.Config(id: 1,
                                                   text: $searchTxt,
                                                   geometry: geometry,
                                                   showButton: true,
                                                   icon: Image("ic_search"),
                                                   action: triggerInputFieldAction)

                ForEach([config, config2], id: \.id) { config in
                    InputFieldView(config: config)
                }
            }
            .padding(.top, 150)

            /**
             ZStack(alignment: .leading) {
                 if model.username.isEmpty {
                     Text(model.emailFieldTitle, comment: "Enter your registered username here")
                         .accessibility(hidden: true)
                         .foregroundColor(.white)
                 }

                 TextField("", text: $model.username)
                     .accessibilityLabel(model.emailFieldTitle)
                     .frame(height: 56, alignment: .leading)
                     .foregroundColor(.white)
             }
             */
        }
        .background(Color.black)
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }

    private func triggerInputFieldAction(id: Int, text: String) {
        print("triggered: \(id) -- \(text)")
    }
}

struct SearchPage_Previews: PreviewProvider {
    static var previews: some View {
        SearchPageView()
    }
}
