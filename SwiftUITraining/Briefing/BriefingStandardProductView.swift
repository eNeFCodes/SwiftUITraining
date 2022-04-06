//
//  BriefingStandardProductView.swift
//  SwiftUITraining
//
//  Created by Neil Francis Hipona on 4/5/22.
//

import SwiftUI

extension BriefingStandardProductView {
    struct Model {
        let imageName: String
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
    var sidePadding: CGFloat = 32
    let model: Model

    var body: some View {
        VStack {
            let estimatedWidth = abs(geometry.size.width - (sidePadding * 2))
            VStack {
                buildProductImageViewStack(estimatedWidth: estimatedWidth)
                    .padding(.top, 8)
                buildTextContentViewStack(estimatedWidth: estimatedWidth)
                    .padding(.top, 16)
                    .padding(.bottom, sidePadding)
            }
            .frame(width: estimatedWidth, alignment: .center)
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
                        .stroke(ColorCollection.gold)
                }
            }
        }
        .frame(width: geometry.size.width, alignment: .center)
    }

    private func buildProductImageViewStack(estimatedWidth: CGFloat) -> some View {
        HStack {
            Spacer()
            let containerSqHeight: CGFloat = 230
            let containerBGFrameWidth = abs(estimatedWidth - 24)
            ZStack {
                VStack { } // background
                .frame(width: containerBGFrameWidth, height: 173, alignment: .center)
                .background(ColorCollection.black)

                Image(model.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: containerSqHeight, height: containerSqHeight, alignment: .center)
                    .clipped()
                    .padding(.trailing, 40)
            }
            .frame(width: containerBGFrameWidth, height: containerSqHeight, alignment: .center)
        }
    }

    private func buildTextContentViewStack(estimatedWidth: CGFloat) -> some View {
        VStack {
            let padding: CGFloat = 24
            let contentWidth = abs(estimatedWidth - (padding * 2))
            buildTextContentTitleViewStack(frameWidth: estimatedWidth, contentWidth: contentWidth)
            buildTextContentDetailsViewStack(frameWidth: estimatedWidth, contentWidth: contentWidth)
        }
    }

    private func buildTextContentTitleViewStack(frameWidth: CGFloat, contentWidth: CGFloat) -> some View {
        VStack(spacing: 8) {
            let titleFont = FontCollection.font(for: FontCollection.BrilliantCutProB7.bold(size: 11))
            Text(model.title)
                .accessibilityLabel(model.title)
                .font(titleFont)
                .foregroundColor(ColorCollection.black)
                .frame(width: contentWidth, alignment: .leading)

            HStack(spacing: 4) {
                let subTitleFieldWidth = abs(contentWidth - 28)
                let subTitleFont = FontCollection.uiFont(for: FontCollection.BrilliantCutProB7.medium(size: 22))!
                let subTitleHeight = model.sutTitle.constrainedSize(with: .init(width: subTitleFieldWidth, height: .infinity),
                                                                    minHeight: 24,
                                                                    font: subTitleFont)
                Text(model.sutTitle)
                    .accessibilityLabel(model.sutTitle)
                    .font(subTitleFont.toFont())
                    .foregroundColor(ColorCollection.black)
                    .frame(width: subTitleFieldWidth, height: subTitleHeight, alignment: .leading)

                VStack(alignment: .trailing, spacing: 0) {
                    Button {

                    } label: {
                        Image("ic_bookmark")
                            .resizable()
                            .frame(width: 24, height: 24, alignment: .center)
                    }
                    Spacer()
                }
                .frame(height: subTitleHeight, alignment: .top)
            }
            .frame(width: contentWidth, alignment: .top)
        }
        .frame(width: frameWidth, alignment: .center)
    }

    private func buildTextContentDetailsViewStack(frameWidth: CGFloat, contentWidth: CGFloat) -> some View {
        VStack(spacing: 16) {
            let detailsFont = FontCollection.font(for: FontCollection.FancyCutProB7.regular(size: 16))
            Text(model.details)
                .accessibilityLabel(model.details)
                .font(detailsFont)
                .foregroundColor(ColorCollection.black)
                .frame(width: contentWidth, alignment: .leading)

            VStack(spacing: 0) {
                let boldFont = FontCollection.font(for: FontCollection.FancyCutProB7.bold(size: 12))
                let regularFont = FontCollection.font(for: FontCollection.FancyCutProB7.regular(size: 12))

                Text(model.time)
                    .accessibilityLabel(model.time)
                    .frame(width: contentWidth, alignment: .leading)
                    .font(boldFont)

                HStack {
                    let authName = "\(model.author),"
                    let authDetails = " \(model.authorDetails)"

                    Text(authName)
                        .accessibilityLabel(authName)
                        .font(boldFont)

                    +

                    Text(authDetails)
                        .accessibilityLabel(authDetails)
                        .font(regularFont)
                }
                .frame(width: contentWidth, alignment: .leading)

                Text(model.location)
                    .accessibilityLabel(model.location)
                    .font(boldFont)
                    .frame(width: contentWidth, alignment: .leading)
            }
            .frame(width: contentWidth, alignment: .leading)
            .foregroundColor(ColorCollection.black)
        }
        .frame(width: frameWidth, alignment: .center)
    }
}

struct BriefingStandardProductView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            BriefingStandardProductView(geometry: geometry, model: BriefingStandardProductView.mockData())
        }
    }
}

extension BriefingStandardProductView {
    static func mockData() -> BriefingStandardProductView.Model {
        .init(imageName: "img_ring",
              title: "TAKEAWAY",
              sutTitle: "Congratulate\nMaria".uppercased(),
              details: "Its five-year mission: to explore strange new worlds, to seek out new life and new civilizations, to boldly go where no man has gone before. Its five-year mission: to explore strange new worlds again.",
              time: "5 mins ago".uppercased(),
              author: "Jane Doe",
              authorDetails: "Lorem Ispum Role",
              location: "5th Avenue Mansion") {

        }
    }
}
