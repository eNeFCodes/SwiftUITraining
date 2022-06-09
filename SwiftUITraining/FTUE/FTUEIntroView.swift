//
//  FTUEIntroView.swift
//  SwiftUITraining
//
//  Created by Neil Francis Hipona on 3/18/22.
//

import SwiftUI

struct FTUEIntroView: View {
    @EnvironmentObject private var appEnv: AppEnv

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack(spacing: 20) {
                    verticalDashes()

                    let squareSize = geometry.size.width * 0.4
                    Image("img_lanyards")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: abs(squareSize), height: abs(squareSize), alignment: .center)
                        .background(ColorCollection.black)


                    let headerStr = "HELLO, \(appEnv.user.username)\nWELCOME TO\nCNT!"
                    Text(headerStr)
                        .accessibilityLabel(headerStr)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 10)
                        .font(.largeTitle)

                    let font = Font.custom("FancyCutProB7-Regular", size: 30)
                    let detailStr = "This is CNT's new Retail Publishing Platform where you can find the latest news and updates around the world at CNT."
                    Text(detailStr)
                        .accessibilityLabel(detailStr)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .font(font)
                    
                    Spacer()
                    verticalDashes()
                }
                .padding(20)
            }
        }
    }

    private func verticalDashes() -> some View {
        return VStack {}
        .frame(width: 2, height: 80, alignment: .center)
        .overlay {
            let start = CGPoint(x: 1, y: 0)
            let end = CGPoint(x: 1, y: 80)
            BorderView(coordinates: [start, end])
                .stroke(style: StrokeStyle(lineWidth: 2, dash: [3]))
                .foregroundColor(.orange)
        }
    }
}

struct FTUEIntroView_Previews: PreviewProvider {
    static var previews: some View {
        FTUEIntroView()
            .environmentObject(AppEnv())
    }
}
