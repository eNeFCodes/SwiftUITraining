//
//  BriefingWeeklyUpdateView.swift
//  SwiftUITraining
//
//  Created by Neil Francis Hipona on 4/5/22.
//

import SwiftUI

struct BriefingWeeklyUpdateView: View {
    let geometry: GeometryProxy

    var body: some View {
        Group {
            let frameWidth = abs(geometry.size.width)
            let frameHeight: CGFloat = 236
            ZStack {
                VStack {
                    Spacer()
                    Image("img_bg_article")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: frameWidth, height: 143, alignment: .top)
                        .clipped()
                }
                .frame(width: frameWidth, height: frameHeight, alignment: .center)

                VStack {
                    let redBGViewWidth = frameWidth - 85
                    let sidePadding: CGFloat = 32
                    VStack {
                        let titleFont = FontCollection.font(for: FontCollection.FancyCutCondProB7.bold(size: 30))
                        let titleString = "This week\naround CNT".uppercased()

                        Text(titleString)
                            .accessibilityLabel(titleString)
                            .foregroundColor(ColorCollection.white)
                            .font(titleFont)
                            .multilineTextAlignment(.trailing)
                    }
                    .padding(.top, sidePadding)
                    .padding(.leading, sidePadding)
                    .padding(.trailing, sidePadding)
                    .frame(width: redBGViewWidth, height: frameHeight, alignment: .topTrailing)
                    .background(ColorCollection.red)
                    .mask {
                        GeometryReader { geometry in
                            let curve: CGFloat = 20
                            let p1 = CGPoint(x: curve, y: 0)
                            let p2 = CGPoint(x: geometry.size.width, y: 0)
                            let p3 = CGPoint(x: geometry.size.width, y: geometry.size.height)
                            let p4 = CGPoint(x: 0, y: geometry.size.height)
                            let p5 = CGPoint(x: 0, y: curve)
                            BorderView(coordinates: [p1, p2, p3, p4, p5], shouldClosePath: true)
                        }
                    }
                }
                .frame(width: frameWidth, height: frameHeight, alignment: .trailing)
            }
            .frame(width: frameWidth, height: frameHeight, alignment: .center)
        }
    }
}

struct BriefingWeeklyUpdateView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            BriefingWeeklyUpdateView(geometry: geometry)
        }
    }
}
