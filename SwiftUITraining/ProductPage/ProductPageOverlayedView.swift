//
//  ProductPageOverlayedView.swift
//  SwiftUITraining
//
//  Created by Neil Francis Hipona on 4/4/22.
//

import SwiftUI

extension ProductPageOverlayedView {
    struct Model {
        let contentDetails: String?
        let collectionTitle: String
        let collectionDetails: String

        let products: [SearchPageView.Searched]
    }
}

struct ProductPageOverlayedView: View {
    
    let geometry: GeometryProxy
    let model: Model

    var body: some View {
        let addSpacing: CGFloat = (model.contentDetails ?? "").isEmpty ? 0 : 48
        VStack(spacing: addSpacing) {
            let sidePadding: CGFloat = 32
            if let contentDetails = model.contentDetails {
                let detailFont = FontCollection.font(for: FontCollection.FancyCutProB7.regular(size: 18))
                Text(contentDetails)
                    .accessibilityLabel(contentDetails)
                    .font(detailFont)
                    .foregroundColor(ColorCollection.black)
                    .padding(.leading, sidePadding)
                    .padding(.trailing, sidePadding)
                    .frame(width: abs(geometry.size.width), alignment: .leading)
            }

            ZStack {
                VStack {
                    buildTextContentStack(geometry: geometry, sidePadding: sidePadding)
                    Spacer()
                }

                VStack {
                    buildTextContentScrollableViewStack(geometry: geometry, sidePadding: sidePadding)
                }
                .padding(.top, 135)
                .frame(width: geometry.size.width, alignment: .trailing)
            }
            .frame(width: geometry.size.width, alignment: .center)
        }
    }

    private func buildTextContentStack(geometry: GeometryProxy, sidePadding: CGFloat) -> some View {
        Group {
            let collectionViewWidth = abs(geometry.size.width - (sidePadding * 2))
            VStack {
                VStack(spacing: 16) {
                    let textContentWidth = collectionViewWidth - (sidePadding * 2)
                    let titleFont = FontCollection.font(for: FontCollection.FancyCutCondProB7.bold(size: 30))
                    Text(model.collectionTitle)
                        .accessibilityLabel(model.collectionTitle)
                        .foregroundColor(ColorCollection.white)
                        .font(titleFont)
                        .frame(width: textContentWidth, height: 80, alignment: .leading)

                    let p1 = CGPoint(x: 0, y: 0)
                    let p2 = CGPoint(x: textContentWidth, y: 0)
                    BorderView(coordinates: [p1, p2])
                        .stroke(style: StrokeStyle(lineWidth: 1, dash: [2]))
                        .foregroundColor(ColorCollection.gold)
                        .frame(width: textContentWidth, height: 1, alignment: .leading)

                    HStack {
                        let detailContentWidth = abs(textContentWidth - 93)
                        let detailFont = FontCollection.font(for: FontCollection.FancyCutProB7.regular(size: 16))
                        Text(model.collectionDetails)
                            .accessibilityLabel(model.collectionDetails)
                            .foregroundColor(ColorCollection.white)
                            .font(detailFont)
                            .frame(width: detailContentWidth, alignment: .leading)
                    }
                    .padding(.top, 32)
                    .frame(width: textContentWidth, height: 190, alignment: .topLeading)

                    HStack {
                        Image("ic_3arrow_gold")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 11, alignment: .leading)
                    }
                    .padding(.trailing, 110)
                    .frame(width: textContentWidth, alignment: .trailing)
                }
                .padding(.top, 40)
                .padding(.leading, sidePadding)
                .padding(.trailing, sidePadding)
                .frame(width: collectionViewWidth, alignment: .leading)

                Spacer()
            }
            .frame(width: collectionViewWidth, height: 415, alignment: .center)
            .background(ColorCollection.black)
            .mask {
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
                }
            }
        }
    }

    private func buildTextContentScrollableViewStack(geometry: GeometryProxy, sidePadding: CGFloat) -> some View {
        Group {
            let startLeadPadding = abs(geometry.size.width - 180)
            ScrollView(.horizontal, showsIndicators: false) {
                ScrollViewReader { proxy in
                    LazyHStack {
                        ForEach(0..<model.products.count, id: \.self) { i in
                            let product = model.products[i]
                            let leadPadding = i == 0 ? startLeadPadding : 0
                            SearchResultItemView(geometry: geometry, item: product, sidePadding: sidePadding, showSeparator: false) { item in
                                print("tapped: ", item)
                            }
                            .padding(.leading, leadPadding)
                        }
                    }
                }
            }
        }
    }
}

struct ProductPageOverlayedView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            ProductPageOverlayedView(geometry: geometry, model: ProductPageOverlayedView.mockData())
        }
    }
}

extension ProductPageOverlayedView {
    static func mockData() -> ProductPageOverlayedView.Model {
        .init(contentDetails: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent nec augue tempus erat luctus consequat. In venenatis varius imperdiet. Donec non massa eu enim dapibus ullamcorper. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent nec augue tempus erat luctus consequat. In venenatis varius imperdiet. Donec non massa eu enim dapibus ullamcorper.",
              collectionTitle: "DISCOVER the collection".uppercased(),
              collectionDetails: "Here's a selection of articles about Trinity Collection.",
              products: [
                .init(id: 0,
                      title: "EYEBROW",
                      subTitle: "A NEW CHAPTER ON NEW BOND STREET",
                      imageName: "img_result5",
                      date: "MAR. 1, 2020"),
                .init(id: 0,
                      title: "EYEBROW",
                      subTitle: "A NEW CHAPTER ON NEW BOND STREET",
                      imageName: "img_result5",
                      date: "MAR. 1, 2020")
              ])
    }

    static func mockData2() -> ProductPageOverlayedView.Model {
        .init(contentDetails: "",
              collectionTitle: "DISCOVER the collection".uppercased(),
              collectionDetails: "Here's a selection of articles about Trinity Collection.",
              products: [
                .init(id: 0,
                      title: "EYEBROW",
                      subTitle: "A NEW CHAPTER ON NEW BOND STREET",
                      imageName: "img_result5",
                      date: "MAR. 1, 2020"),
                .init(id: 0,
                      title: "EYEBROW",
                      subTitle: "A NEW CHAPTER ON NEW BOND STREET",
                      imageName: "img_result5",
                      date: "MAR. 1, 2020")
              ])
    }
}
