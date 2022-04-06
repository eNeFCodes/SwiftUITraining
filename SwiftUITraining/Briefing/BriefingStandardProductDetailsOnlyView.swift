//
//  BriefingStandardProductDetailsOnlyView.swift
//  SwiftUITraining
//
//  Created by Neil Francis Hipona on 4/6/22.
//

import SwiftUI

extension BriefingStandardProductDetailsOnlyView {
    struct Model {
        let title: String
        let sutTitle: String
        let details: String
        let date: String

        let action: () -> Void
    }
}

struct BriefingStandardProductDetailsOnlyView: View {
    let geometry: GeometryProxy
    var sidePadding: CGFloat = 32
    let model: Model

    var body: some View {
        VStack(spacing: 16) {
            let estimatedWidth = abs(geometry.size.width - (sidePadding * 2))
            buildTextContentTitleViewStack(frameWidth: estimatedWidth)
            buildTextContentDetailsViewStack(frameWidth: estimatedWidth)
        }
        .frame(width: geometry.size.width, alignment: .center)
    }

    private func buildTextContentTitleViewStack(frameWidth: CGFloat) -> some View {
        VStack(spacing: 8) {
            let titleFont = FontCollection.font(for: FontCollection.BrilliantCutProB7.bold(size: 11))
            Text(model.title)
                .accessibilityLabel(model.title)
                .font(titleFont)
                .foregroundColor(ColorCollection.black)
                .frame(width: frameWidth, alignment: .leading)

            HStack(spacing: 4) {
                let subTitleFieldWidth = abs(frameWidth - 28)
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
            .frame(width: frameWidth, alignment: .top)
        }
        .frame(width: frameWidth, alignment: .center)
    }

    private func buildTextContentDetailsViewStack(frameWidth: CGFloat) -> some View {
        VStack(spacing: 16) {
            let detailsFont = FontCollection.font(for: FontCollection.FancyCutProB7.light(size: 22))
            Text(model.details)
                .accessibilityLabel(model.details)
                .font(detailsFont)
                .foregroundColor(ColorCollection.black)
                .frame(width: frameWidth, alignment: .leading)

            let dateFont = FontCollection.font(for: FontCollection.FancyCutProB7.bold(size: 12))
            Text(model.date)
                .accessibilityLabel(model.date)
                .frame(width: frameWidth, alignment: .leading)
                .font(dateFont)
        }
        .frame(width: frameWidth, alignment: .center)
    }
}

struct BriefingStandardProductDetailsOnlyView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            BriefingStandardProductDetailsOnlyView(geometry: geometry, model: BriefingStandardProductDetailsOnlyView.mockData())
        }
    }
}

extension BriefingStandardProductDetailsOnlyView {
    static func mockData() -> BriefingStandardProductDetailsOnlyView.Model {
        .init(title: "EYEBROW",
              sutTitle: "Biasas fsa Vehicula Etiam Egestas lorem ipsum".uppercased(),
              details: "Nam ultrices dictum nunc at tempus. Praesent bibendum tellus tellus, quis fringilla quam convallis sed lorem ipsum longer sentence bla bla something else.",
              date: "MAR. 1, 2020") {

        }
    }
}
