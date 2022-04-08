//
//  ResourceNavigationView.swift
//  SwiftUITraining
//
//  Created by Neil Francis Hipona on 4/8/22.
//

import SwiftUI

struct ResourceNavigationView: View {
    let geometry: GeometryProxy
    let model: ResourceNavigationViewModel
    private let maxNavHeight: CGFloat = 54

    var body: some View {
        ZStack {
            let estimatedWidth = abs(geometry.size.width - (model.sidePadding * 2))
            buildTitleStack(estimatedWidth: estimatedWidth)
            buildButtonStack(estimatedWidth: estimatedWidth)

            VStack {
                Spacer()
                let p1 = CGPoint(x: 0, y: 0)
                let p2 = CGPoint(x: estimatedWidth, y: 0)
                BorderView(coordinates: [p1, p2])
                    .stroke(style: StrokeStyle(lineWidth: 1, dash: [2]))
                    .foregroundColor(ColorCollection.black)
                    .frame(width: estimatedWidth, height: 1)
            }
            .frame(width: estimatedWidth, height: maxNavHeight, alignment: .bottom)
        }
        .padding(.leading, model.sidePadding)
        .padding(.trailing, model.sidePadding)
        .frame(width: geometry.size.width, height: maxNavHeight, alignment: .center)
    }

    private func buildTitleStack(estimatedWidth: CGFloat) -> some View {
        HStack {
            let textContentWidth = abs(estimatedWidth - 148)
            VStack(spacing: 0) {
                if let logo = model.logo {
                    Image(logo)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 42, alignment: .topLeading)
                } else {
                    let titleFont = FontCollection.font(for: FontCollection.BrilliantCutProB7.bold(size: 28))
                    Text(model.title)
                        .accessibilityLabel(model.title)
                        .font(titleFont)
                        .foregroundColor(ColorCollection.black)
                        .frame(width: textContentWidth, height: 30, alignment: .leading)

                    let subTitleFont = FontCollection.font(for: FontCollection.BrilliantCutProB7.regular(size: 11))
                    Text(model.subTitle)
                        .accessibilityLabel(model.subTitle)
                        .font(subTitleFont)
                        .foregroundColor(ColorCollection.black)
                        .frame(width: textContentWidth, height:20, alignment: .leading)
                }
            }
            .frame(width: textContentWidth, height: maxNavHeight, alignment: .topLeading)
            Spacer()
        }
        .frame(width: estimatedWidth, height: maxNavHeight, alignment: .leading)
    }

    private func buildButtonStack(estimatedWidth: CGFloat) -> some View {
        VStack {
            HStack(spacing: 16) {
                Button {
                    model.btnSearchAction()
                } label: {
                    Image("ic_search_32x32_black")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 32, height: 32, alignment: .center)
                }

                Button {
                    model.btnProfileAction()
                } label: {
                    Image("ic_profile_32x32_black")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 32, height: 32, alignment: .center)
                }
            }
            Spacer()
        }
        .frame(width: estimatedWidth, height: maxNavHeight, alignment: .trailing)
    }
}

struct ResourceNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            let model = ResourceNavigationViewModel(title: "CNT",
                                        subTitle: "JEWELRY",
                                        logo: "ic_cartier_logo") {

            } btnProfileAction: {

            }
            ResourceNavigationView(geometry: geometry, model: model)
        }
    }
}
