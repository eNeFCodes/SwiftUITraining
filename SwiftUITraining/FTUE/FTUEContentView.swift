//
//  FTUEContentView.swift
//  SwiftUITraining
//
//  Created by Neil Francis Hipona on 3/18/22.
//

import SwiftUI

struct FTUEContentView: View {

    @EnvironmentObject private var appEnv: AppEnv

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    Spacer()
                    Image("img_bg_login")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 230, alignment: .top)
                }
                ScrollView(.horizontal) {
                    HStack {
                        VStack {
                            FTUEIntroView()
                        }
                        .frame(width: abs(geometry.size.width), alignment: .center)

                        VStack {
                            FTUEIntroView()
                        }
                        .frame(width: abs(geometry.size.width), alignment: .center)

                        VStack {
                            FTUEIntroView()
                        }
                        .frame(width: abs(geometry.size.width), alignment: .center)
                    }
                    .padding(.top, 20)
                    .padding(.bottom, 100)
                }
                VStack {
                    Button("X") {
                        print("close")
                    }
                    .frame(width: 50, height: 50)
                    .foregroundColor(.white)
                    Spacer()
                }
                .padding(20)
                .padding(.top, 20)
                .frame(width: abs(geometry.size.width), alignment: .trailing)

                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        dotIndicator(isActive: true)
                        dotIndicator()
                        dotIndicator()
                        Spacer()
                    }
                    .padding(20)
                    .frame(width: abs(geometry.size.width))
                    .padding(.bottom, 40)
                }
            }
        }
        .background(Color.black)
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }

    private func dotIndicator(isActive: Bool = false) -> some View {
        Circle()
            .frame(width: 20, height: 20, alignment: .center)
            .foregroundColor(.green)
    }
}

struct FTUEView_Previews: PreviewProvider {
    static var previews: some View {
        FTUEContentView()
    }
}
