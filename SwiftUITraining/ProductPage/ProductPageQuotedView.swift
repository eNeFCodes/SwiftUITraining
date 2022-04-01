//
//  ProductPageQuotedView.swift
//  SwiftUITraining
//
//  Created by Neil Francis Hipona on 4/1/22.
//

import SwiftUI

extension ProductPageQuotedView {
    struct Model {
        struct Quote: Identifiable {
            let id: Int
            let detail: String
            let copyright: String

            var number: String {
                id > 9 ? "\(id)" : "0\(id)"
            }
        }

        let detail: String
        let quotes: [Quote]
    }
}

struct ProductPageQuotedView: View {
    let geometry: GeometryProxy
    let model: Model = ProductPageQuotedView.mockData()
    @State private var currentIndex: Int = 0

    var body: some View {
        VStack {
            let sidePadding: CGFloat = 32
            let detailFont = FontCollection.font(for: FontCollection.FancyCutProB7.regular(size: 18))
            Text(model.detail)
                .accessibilityLabel(model.detail)
                .font(detailFont)
                .foregroundColor(ColorCollection.black)
                .padding(.leading, sidePadding)
                .padding(.trailing, sidePadding)
                .frame(width: abs(geometry.size.width), alignment: .leading)

            ZStack {
                VStack {
                    Spacer()
                    buildContentStack(geometry: geometry)
                        .padding(.top, 50)
                }
                VStack {
                    Image("img_quote_stroke")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 162, height: 89, alignment: .center)
                        .padding(.leading, 88)
                        .clipped()
                    Spacer()
                }
                .frame(width: abs(geometry.size.width), alignment: .leading)
            }
            .padding(.top, 30)
        }
    }

    private func buildContentStack(geometry: GeometryProxy) -> some View {
        Group {
            let estimatedWidth = abs(geometry.size.width - 32)
            VStack { // main view - black bg
                let coloredViewBGWidth = abs(estimatedWidth - 40)
                let sidePadding: CGFloat = 32

                VStack(spacing: 8) { // secondary view - content view
                    buildContentScrollViewStack(maxWidth: coloredViewBGWidth)

                    let maxIndex = model.quotes.count - 1
                    DotOnlyView(dotColor: ColorCollection.black,
                                dotStrokeColor: ColorCollection.black,
                                dotInactiveStrokeColor: ColorCollection.black,
                                range: 0...maxIndex,
                                activeIndex: $currentIndex)
                        .padding(.leading, sidePadding)
                        .padding(.trailing, sidePadding)
                        .padding(.top, 24)
                        .frame(width: coloredViewBGWidth, height: 40, alignment: .leading)
                        .padding(.bottom, 40)
                }
                .frame(width: coloredViewBGWidth, alignment: .center)
                .background(ColorCollection.lightBeige)
            }
            .frame(width: estimatedWidth, alignment: .trailing)
            .background(ColorCollection.black)
            .mask {
                GeometryReader { geometry in
                    let curve: CGFloat = 20
                    let p1 = CGPoint(x: curve, y: 0)
                    let p2 = CGPoint(x: estimatedWidth, y: 0)
                    let p3 = CGPoint(x: estimatedWidth, y: geometry.size.height)
                    let p4 = CGPoint(x: 0, y: geometry.size.height)
                    let p5 = CGPoint(x: 0, y: curve)
                    BorderView(coordinates: [p1, p2, p3, p4, p5], shouldClosePath: true)
                }
            }
        }
    }

    private func buildContentScrollViewStack(maxWidth: CGFloat) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            ScrollViewReader { proxy in
                LazyHStack {
                    ForEach(0..<model.quotes.count, id: \.self) { i in
                        let item = model.quotes[i]
                        buildContentScrollViewTextStack(maxWidth: maxWidth, item: item, tag: i)
                    }
                }
                .onChange(of: currentIndex) { newValue in
                    withAnimation {
                        proxy.scrollTo(newValue, anchor: .center)
                    }
                }
            }
            .background {
                GeometryReader { geometry in
                    Color.clear.preference(key: ScrollViewOffsetKey.self,
                                           value: abs(geometry.frame(in: .named("scroll")).origin.x))
                }
            }
        }
        .coordinateSpace(name: "scroll")
        .padding(.top, 70)
    }

    private func buildContentScrollViewTextStack(maxWidth: CGFloat, item: Model.Quote, tag i: Int) -> some View {
        Group {
            let sidePadding: CGFloat = 32
            let textViewWidth = maxWidth - (sidePadding * 2)
            let textCanvas = CGSize(width: textViewWidth, height: .infinity)
            let detailFont = FontCollection.uiFont(for: FontCollection.FancyCutProB7.light(size: 29))!
            let copyrightFont = FontCollection.uiFont(for: FontCollection.FancyCutProB7.bold(size: 16))!

            VStack(spacing: 8) {
                let detailHeight = item.detail.constrainedSize(with: textCanvas, minHeight: 32, font: detailFont)
                Text(item.detail)
                    .accessibilityLabel(item.detail)
                    .font(detailFont.toFont())
                    .foregroundColor(ColorCollection.black)
                    .padding(.leading, sidePadding)
                    .padding(.trailing, sidePadding)
                    .frame(width: maxWidth, height: detailHeight, alignment: .leading)

                let copyrightHeight = item.copyright.constrainedSize(with: textCanvas, minHeight: 18, font: copyrightFont)
                Text(item.copyright)
                    .accessibilityLabel(item.copyright)
                    .font(copyrightFont.toFont())
                    .foregroundColor(ColorCollection.black)
                    .padding(.leading, sidePadding)
                    .padding(.trailing, sidePadding)
                    .frame(width: maxWidth, height: copyrightHeight, alignment: .leading)
            }
            .frame(width: maxWidth, alignment: .leading)
            .tag(i)
        }
    }
}

struct ProductPageQuotedView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            ProductPageQuotedView(geometry: geometry)
        }
    }
}

extension ProductPageQuotedView {
    static func mockData() -> ProductPageQuotedView.Model {
        .init(detail: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent nec augue tempus erat luctus consequat. In venenatis varius imperdiet. Donec non massa eu enim dapibus ullamcorper.",
              quotes: [
                .init(id: 0,
                      detail: "Iconic? Perennial? Ubiquitous? None of these seems strong enough to describe the Panthére within the design oeuvre of Cartier.",
                      copyright: "Jane Doe, Lorem Ispum Role"),
                .init(id: 1,
                      detail: "Iconic? Perennial? Ubiquitous? None of these seems strong enough to describe the Panthére within the design oeuvre of Cartier.",
                      copyright: "Jane Doe, Lorem Ispum Role"),
                .init(id: 2,
                      detail: "Iconic? Perennial? Ubiquitous? None of these seems strong enough to describe the Panthére within the design oeuvre of Cartier.",
                      copyright: "Jane Doe, Lorem Ispum Role"),
                .init(id: 3,
                      detail: "Iconic? Perennial? Ubiquitous? None of these seems strong enough to describe the Panthére within the design oeuvre of Cartier.",
                      copyright: "Jane Doe, Lorem Ispum Role"),
                .init(id: 4,
                      detail: "Iconic? Perennial? Ubiquitous? None of these seems strong enough to describe the Panthére within the design oeuvre of Cartier.",
                      copyright: "Jane Doe, Lorem Ispum Role"),
                .init(id: 5,
                      detail: "Iconic? Perennial? Ubiquitous? None of these seems strong enough to describe the Panthére within the design oeuvre of Cartier.",
                      copyright: "Jane Doe, Lorem Ispum Role")
              ])
    }
}
