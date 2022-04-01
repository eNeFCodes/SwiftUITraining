//
//  ProductPageDetailsView.swift
//  SwiftUITraining
//
//  Created by Neil Francis Hipona on 3/31/22.
//

import SwiftUI

extension ProductPageDetailsView {
    struct Model {
        struct AboutDetail: Identifiable {
            let id: Int
            let detail: String
            let copyright: String

            var number: String {
                id > 9 ? "\(id)" : "0\(id)"
            }
        }

        let aboutIntro: String
        let aboutTitle: String
        let productImage: Image
        let aboutDetails: [AboutDetail]

        var aboutDetailsCount: String {
            aboutDetails.count > 9 ? "\(aboutDetails.count)" : "0\(aboutDetails.count)"
        }
    }
}

struct ProductPageDetailsView: View {
    let geometry: GeometryProxy
    let model: Model = ProductPageDetailsView.mockData()

    @State private var aboutDetailsCurrentIndex: Int = 0

    var body: some View {
        VStack {
            buildAboutIntroStack(geometry: geometry)
            buildAboutProductStack(geometry: geometry)
        }
    }

    private func buildAboutIntroStack(geometry: GeometryProxy) -> some View {
        VStack {
            let estimatedWidth = abs(geometry.size.width - 64)
            let aboutIntroFont = FontCollection.font(for: FontCollection.FancyCutProB7.regular(size: 18))
            Text(model.aboutIntro)
                .accessibilityLabel(model.aboutIntro)
                .foregroundColor(ColorCollection.black)
                .font(aboutIntroFont)
                .frame(width: estimatedWidth, alignment: .leading)

            let aboutTitleFont = FontCollection.font(for: FontCollection.FancyCutCondProB7.bold(size: 30))
            Text(model.aboutTitle)
                .accessibilityLabel(model.aboutTitle)
                .foregroundColor(ColorCollection.black)
                .font(aboutTitleFont)
                .frame(width: estimatedWidth, alignment: .leading)
                .padding(.top, 48)
        }
        .padding(.leading, 32)
        .padding(.trailing, 32)
        .frame(width: geometry.size.width, alignment: .leading)
    }

    private func buildAboutProductStack(geometry: GeometryProxy) -> some View  {
        VStack {
            ZStack {
                VStack {
                    model.productImage
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: 481, alignment: .top)
                        .clipped()
                    Spacer()
                }

                VStack(alignment: .trailing) {
                    Spacer()
                    let productDetailsViewWidth = abs(geometry.size.width - 44)
                    let sidePadding: CGFloat = 26
                    VStack {
                        ZStack {
                            VStack {
                                HStack(spacing: 4) { // Pagination
                                    let numberFont = FontCollection.font(for: FontCollection.FancyCutProB7.bold(size: 24))
                                    let numberIdx = aboutDetailsCurrentIndex + 1
                                    let numberIdxFormat = numberIdx > 9 ? "\(numberIdx)" : "0\(numberIdx)"

                                    Text(numberIdxFormat)
                                        .accessibilityLabel(numberIdxFormat)
                                        .font(numberFont)
                                        .foregroundColor(ColorCollection.white)

                                    Image("ic_line_number_separator")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 21, height: 40, alignment: .center)
                                        .clipped()

                                    Text(model.aboutDetailsCount)
                                        .accessibilityLabel(model.aboutDetailsCount)
                                        .font(numberFont)
                                        .foregroundColor(ColorCollection.gold)
                                }
                                .padding(.leading, sidePadding)
                                .frame(width: productDetailsViewWidth, height: 67, alignment: .leading)
                                Spacer()
                            }

                            VStack {
                                Spacer()
                                let productDetailsMaskedViewWidth = productDetailsViewWidth - 35
                                let detailsStackViewHeight: CGFloat = 166
                                HStack {
                                    VStack(spacing: 16) { // Details
                                        buildAboutProductScrollViewStack(maxWidth: productDetailsMaskedViewWidth)

                                        let maxIndex = model.aboutDetails.count - 1
                                        DotOnlyView(dotColor: ColorCollection.white,
                                                    dotStrokeColor: ColorCollection.white,
                                                    dotInactiveStrokeColor: ColorCollection.whiteInactiveDotColor,
                                                    range: 0...maxIndex,
                                                    activeIndex: $aboutDetailsCurrentIndex)
                                            .padding(.leading, sidePadding)
                                            .padding(.trailing, sidePadding)
                                            .frame(width: productDetailsMaskedViewWidth, alignment: .leading)
                                            .padding(.bottom, 40)
                                    }
                                    .padding(.top, 24)
                                    .frame(width: productDetailsMaskedViewWidth, height: detailsStackViewHeight, alignment: .leading)
                                    .background(ColorCollection.red)
                                    .mask {
                                        let curve: CGFloat = 20
                                        let p1 = CGPoint(x: 0, y: 0)
                                        let p2 = CGPoint(x: productDetailsMaskedViewWidth - curve, y: 0)
                                        let p3 = CGPoint(x: productDetailsMaskedViewWidth, y: curve)
                                        let p4 = CGPoint(x: productDetailsMaskedViewWidth, y: detailsStackViewHeight)
                                        let p5 = CGPoint(x: 0, y: detailsStackViewHeight)
                                        BorderView(coordinates: [p1, p2, p3, p4, p5], shouldClosePath: true)
                                    }
                                    Spacer()
                                }
                                .frame(width: productDetailsViewWidth, height: detailsStackViewHeight, alignment: .leading)
                            }
                        }
                    }
                    .frame(width: productDetailsViewWidth, height: 233, alignment: .leading)
                    .background(ColorCollection.black)
                }
                .frame(width: geometry.size.width, alignment: .trailing)
            }
        }
        .frame(width: geometry.size.width, height: 647, alignment: .trailing)
    }

    private func buildAboutProductScrollViewStack(maxWidth: CGFloat, definedHeight: CGFloat = 100) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            ScrollViewReader { proxy in
                LazyHStack {
                    ForEach(0..<model.aboutDetails.count, id: \.self) { i in
                        let item = model.aboutDetails[i]
                        drawAboutProductDetailStack(maxWidth: maxWidth, definedHeight: definedHeight, item: item, tag: i)
                    }
                }
                .onChange(of: aboutDetailsCurrentIndex) { newValue in
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
        .frame(width: maxWidth, height: definedHeight, alignment: .center)
    }

    private func drawAboutProductDetailStack(maxWidth: CGFloat, definedHeight: CGFloat, item: Model.AboutDetail, tag i: Int) -> some View {
        VStack(spacing: 12) {
            let sidePadding: CGFloat = 26
            let detailFont = FontCollection.font(for: FontCollection.FancyCutProB7.regular(size: 16))
            Text(item.detail)
                .accessibilityLabel(item.detail)
                .padding(.leading, sidePadding)
                .padding(.trailing, sidePadding)
                .frame(width: maxWidth, height: 66, alignment: .topLeading)
                .foregroundColor(ColorCollection.white)
                .font(detailFont)

            let copyrightFont = FontCollection.font(for: FontCollection.FancyCutProB7.light(size: 12))
            Text(item.copyright)
                .accessibilityLabel(item.copyright)
                .padding(.leading, sidePadding)
                .padding(.trailing, sidePadding)
                .frame(width: maxWidth, height: 14, alignment: .topLeading)
                .foregroundColor(ColorCollection.white)
                .font(copyrightFont)
        }
        .frame(width: maxWidth, height: definedHeight, alignment: .center)
        .tag(i)
    }
}

struct ProductPageDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            ProductPageDetailsView(geometry: geometry)
        }
    }
}

extension ProductPageDetailsView {

    static func mockData() -> ProductPageDetailsView.Model {
        .init(aboutIntro: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent nec augue tempus erat luctus consequat. In venenatis varius imperdiet. Donec non massa eu enim dapibus ullamcorper.",
              aboutTitle: "Around the Panthère BRACELET".uppercased(),
              productImage: Image("img_product_showcase1"),
              aboutDetails: [
                .init(id: 0,
                      detail: "Miranda Kerr wearing the Juste Un Clou bracelet for the opening of an exhibition in 2012 something more.",
                      copyright: "Photograph: Menahem Kahana/Getty Images."),
                .init(id: 1,
                      detail: "Miranda Kerr wearing the Juste Un Clou bracelet for the opening of an exhibition in 2012 something more.",
                      copyright: "Photograph: Menahem Kahana/Getty Images."),
                .init(id: 2,
                      detail: "Miranda Kerr wearing the Juste Un Clou bracelet for the opening of an exhibition in 2012 something more.",
                      copyright: "Photograph: Menahem Kahana/Getty Images."),
                .init(id: 3,
                      detail: "Miranda Kerr wearing the Juste Un Clou bracelet for the opening of an exhibition in 2012 something more.",
                      copyright: "Photograph: Menahem Kahana/Getty Images."),
                .init(id: 4,
                      detail: "Miranda Kerr wearing the Juste Un Clou bracelet for the opening of an exhibition in 2012 something more.",
                      copyright: "Photograph: Menahem Kahana/Getty Images."),
                .init(id: 5,
                      detail: "Miranda Kerr wearing the Juste Un Clou bracelet for the opening of an exhibition in 2012 something more.",
                      copyright: "Photograph: Menahem Kahana/Getty Images.")
              ])
    }
}
