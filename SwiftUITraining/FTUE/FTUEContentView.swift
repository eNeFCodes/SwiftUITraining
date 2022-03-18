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
                    Color.orange
                        .frame(width: 2, height: 80, alignment: .center)
                        .padding(.top, 60)
                    Spacer()
                }

                VStack {
                    VStack {
                        Button("X") {
                            print("close")
                        }
                        .foregroundColor(.white)
                        .frame(width: 50, height: 50)
                    }
                    .padding(.trailing, 20)
                    .frame(width: abs(geometry.size.width), alignment: .trailing)

                    VStack{
                        let squareSize = geometry.size.width * 0.4
                        Image("img_lanyards")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: abs(squareSize), height: abs(squareSize), alignment: .center)
                    }
                    .padding(.top, 20)
                    Spacer()
                }
                .padding(.top, 80)

                VStack {
                    let headerStr = "HELLO, \(appEnv.user.username)\nWELCOME TO\nCNT!"
                    Text(headerStr)
                        .foregroundColor(.green)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 10)
                    Text("This is CNT's new Retail Publishing Platform where you can find the latest news and updates around the world at CNT.")
                        .foregroundColor(.green)
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                .padding(20)
                .frame(width: abs(geometry.size.width), alignment: .top)
                .padding(.top, 330)
            }
        }
        .background(Color.black)
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}

struct FTUEView_Previews: PreviewProvider {
    static var previews: some View {
        FTUEContentView()
    }
}
