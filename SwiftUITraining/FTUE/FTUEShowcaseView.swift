//
//  FTUEShowcaseView.swift
//  SwiftUITraining
//
//  Created by Neil Francis Hipona on 3/21/22.
//

import SwiftUI

struct FTUEShowcaseView: View {

    struct ShowcaseItem {
        let title: String
        let detail: String
        let content: Image
    }

    var item: ShowcaseItem

    var body: some View {
        GeometryReader { geometry in
            VStack {
                VStack(spacing: 10) {
                    let titleFont = Font.custom("FancyCutCondProB7-Bold", size: 35)
                    Text(item.title)
                        .accessibilityLabel(item.title)
                        .font(titleFont)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.top, 50)

                    let detailFont = Font.custom("FancyCutProB7-Regular", size: 25)
                    Text(item.detail)
                        .accessibilityLabel(item.detail)
                        .font(detailFont)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                }
                .padding(20)

                Spacer()

                ZStack {
                    GeometryReader { geometry in
                        VStack { Spacer() }
                        .frame(width: abs(geometry.size.width), alignment: .center)
                        .overlay {
                            let cornerSize: CGFloat = 15
                            let offsetY: CGFloat = 60
                            let p1 = CGPoint(x: cornerSize, y: offsetY)
                            let p2 = CGPoint(x: geometry.size.width - cornerSize, y: offsetY)
                            let p3 = CGPoint(x: geometry.size.width, y: offsetY + cornerSize)
                            let p4 = CGPoint(x: geometry.size.width, y: geometry.size.height - cornerSize)
                            let p5 = CGPoint(x: geometry.size.width - cornerSize, y: geometry.size.height)
                            let p6 = CGPoint(x: cornerSize, y: geometry.size.height)
                            let p7 = CGPoint(x: 0, y: geometry.size.height - cornerSize)
                            let p8 = CGPoint(x: 0, y: offsetY + cornerSize)

                            BorderView(coordinates: [p1, p2, p3, p4, p5, p6, p7, p8], shouldClosePath: true)
                                .stroke(Color.orange, lineWidth: 1)
                        }

                        HStack(alignment: .bottom) {
                            let squareSize = geometry.size.width * 0.6
                            item.content
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: abs(squareSize), alignment: .center)
                                .background(Color.clear)
                                .padding(.bottom, 50)
                        }
                        .frame(width: abs(geometry.size.width), alignment: .center)
                    }
                    .padding(20)
                    .padding(.bottom, 30)
                    .frame(height: 520, alignment: .center)
                }
            }
        }
    }
}

struct FTUEShowcaseView_Previews: PreviewProvider {
    static var item: FTUEShowcaseView.ShowcaseItem = .init(title: "Test", detail: "Detail", content: Image("img_ftue2"))

    static var previews: some View {
        FTUEShowcaseView(item: item)
    }
}
