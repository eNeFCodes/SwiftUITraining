//
//  BriefingStandardProductView.swift
//  SwiftUITraining
//
//  Created by Neil Francis Hipona on 4/5/22.
//

import SwiftUI

extension BriefingStandardProductView {
    struct Model {
        let title: String
        let sutTitle: String
        let details: String
        let time: String
        let author: String
        let authorDetails: String
        let location: String

        let action: () -> Void
    }
}

struct BriefingStandardProductView: View {
    let geometry: GeometryProxy

    var body: some View {
        Group {
            VStack {
                buildProductImageViewStack(geometry: geometry)

            }
            .frame(width: abs(geometry.size.width), height: 300, alignment: .center)
            .overlay {
                GeometryReader { geometry in
                    let curve: CGFloat = 20
                    let width = geometry.size.width
                    let height = geometry.size.height

                    let p1 = CGPoint(x: curve, y: 0)
                    let p2 = CGPoint(x: width - curve, y: 0)
                    let p3 = CGPoint(x: width, y: curve)
                    let p4 = CGPoint(x: width, y: height - curve)
                    let p5 = CGPoint(x: width - curve, y: height)
                    let p6 = CGPoint(x: curve, y: height)
                    let p7 = CGPoint(x: 0, y: height - curve)
                    let p8 = CGPoint(x: 0, y: curve)
                    BorderView(coordinates: [p1, p2, p3, p4, p5, p6, p7, p8], shouldClosePath: true)
                        .stroke(style: StrokeStyle(lineWidth: 1, dash: [2]))
                }
            }
        }
    }

    private func buildProductImageViewStack(geometry: GeometryProxy) -> some View {
        HStack {
            Spacer()
            let padding: CGFloat = 32
            let containerHeight: CGFloat = 230
            let containerBGFrameWidth = abs(geometry.size.width - padding - 24)
            ZStack {
                VStack { } // background
                .frame(width: containerBGFrameWidth, height: 173, alignment: .center)
                .background(ColorCollection.black)

                Image("img_ring")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 230, height: containerHeight, alignment: .center)
                    .clipped()
                    .padding(.trailing, 40)
            }
            .frame(width: containerBGFrameWidth, height: containerHeight, alignment: .center)
        }
    }

    private func buildTextContentViewStack(geometry: GeometryProxy) -> some View {
        VStack {
            let padding: CGFloat = 32
            let estimatedWidth = abs(geometry.size.width - (padding * 2))
            buildTextContentTitleViewStack(frameWidth: estimatedWidth)
        }
    }

    private func buildTextContentTitleViewStack(frameWidth: CGFloat) -> some View {
        VStack {
            let titleFont = FontCollection.font(for: FontCollection.BrilliantCutProB7.bold(size: 11))
            Text("")
                .accessibilityLabel("")
                .font(titleFont)
                .foregroundColor(ColorCollection.black)
                .frame(width: frameWidth, alignment: .leading)

            HStack(spacing: 4) {
                let subTitleFont = FontCollection.font(for: FontCollection.BrilliantCutProB7.medium(size: 22))
                Text("")
                    .accessibilityLabel("")
                    .font(subTitleFont)
                    .foregroundColor(ColorCollection.black)
                    .frame(width: frameWidth, alignment: .leading)

                Button {

                } label: {
                    Image("ic_bookmark")
                        .resizable()
                        .frame(width: 24, height: 24, alignment: .center)
                }
            }
        }
        .frame(width: frameWidth, alignment: .leading)
    }
}

struct BriefingStandardProductView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            BriefingStandardProductView(geometry: geometry)
        }
    }
}
