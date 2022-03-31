//
//  ProductPageCollectionView.swift
//  SwiftUITraining
//
//  Created by Neil Francis Hipona on 3/29/22.
//

import SwiftUI

extension ProductPageCollectionView {

    struct Model {
        struct Media: Identifiable {
            let id: Int
            let image: String
        }

        struct SellingPoint: Identifiable {
            let id: Int
            let detail: String

            var number: String {
                id > 9 ? "\(id)" : "0\(id)"
            }
        }

        let miniTitle: String
        let title: String
        let edition: String
        let images: [Media]
        let detail: String

        let materials: String
        let globalPrice: String
        let reference: String
        let launchDate: String
        let sellingPointTitle: String
        let sellingPoints: [SellingPoint]

        var mediaCount: String {
            return images.count > 9 ? "\(images.count)" : "0\(images.count)"
        }

        init(miniTitle: String,
             title: String,
             edition: String,
             images: [Media],
             detail: String,

             materials: String,
             globalPrice: String,
             reference: String,
             launchDate: String,
             sellingPointTitle: String = "KEY SELLING POINTS",
             sellingPoints: [SellingPoint]) {

            self.miniTitle = miniTitle
            self.title = title
            self.edition = edition
            self.images = images
            self.detail = detail

            self.materials = materials
            self.globalPrice = globalPrice
            self.reference = reference
            self.launchDate = launchDate
            self.sellingPointTitle = sellingPointTitle
            self.sellingPoints = sellingPoints
        }
    }
}

struct ProductPageCollectionView: View {

    let geometry: GeometryProxy
    let model: Model = ProductPageCollectionView.mockData()
    @State private var currentIndex: Int = 0

    var body: some View {
        VStack {
            buildHeaderCarouselStack(geometry: geometry)

            VStack {
                buildHeaderTitleStack(geometry: geometry)
                    .padding(.top, 16)

                buildInfoDetailsStack(geometry: geometry)
                    .padding(.top, 40)
            }

            buildProductCatalogStack(geometry: geometry)
                .padding(.top, 32)

            Group {
                let estimatedWidth = abs(geometry.size.width - 64)
                Image("ic_divider_red")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: estimatedWidth, height: 5, alignment: .center)
                    .clipped()
            }
            .padding(.top, 40)

            Group {
                buildSellingPointStack(geometry: geometry)
            }
            .padding(.top, 40)
            .padding(.bottom, 48)
        }
        .background(ColorCollection.lightBeige)
        .padding(.top, 91)
    }

    private func buildHeaderCarouselStack(geometry: GeometryProxy) -> some View { // 295pt
        VStack(spacing: 20) { // Header
            let carouselFrameHeight: CGFloat = 235
            ZStack { // Carousel
                Group {
                    VStack { // Backdrop
                        VStack {}
                        .frame(width: 299, height: 181, alignment: .top)
                        .background(ColorCollection.red)
                        Spacer()
                    }
                    .frame(width: geometry.size.width, height: carouselFrameHeight, alignment: .trailing)

                    VStack {
                        let borderFrameSize = CGSize(width: 288, height: 174)
                        HStack(spacing: 4) {
                            Spacer()
                            Group {
                                let curve: CGFloat = 10
                                let p1 = CGPoint(x: curve, y: 0)
                                let p2 = CGPoint(x: borderFrameSize.width - curve, y: 0)
                                let p3 = CGPoint(x: borderFrameSize.width, y: curve)
                                let p4 = CGPoint(x: borderFrameSize.width, y: borderFrameSize.height - curve)
                                let p5 = CGPoint(x: borderFrameSize.width - curve, y: borderFrameSize.height)
                                let p6 = CGPoint(x: curve, y: borderFrameSize.height)
                                let p7 = CGPoint(x: 0, y: borderFrameSize.height - curve)
                                let p8 = CGPoint(x: 0, y: curve)
                                BorderView(coordinates: [p1, p2, p3, p4, p5, p6, p7, p8], shouldClosePath: true)
                                    .stroke(ColorCollection.gold)
                                    .frame(width: borderFrameSize.width, height: borderFrameSize.height, alignment: .center)
                            }
                            Spacer()
                        }
                        .frame(width: geometry.size.width, height: borderFrameSize.height, alignment: .bottom)
                    }
                    .frame(width: geometry.size.width, height: carouselFrameHeight, alignment: .bottom)
                }
                .frame(width: geometry.size.width, height: carouselFrameHeight, alignment: .center)

                buildCarouselScrollViewStack(geometry: geometry)

                Group {
                    HStack {
                        Button {
                            print("Fire")
                            currentIndex = currentIndex > 0 ? currentIndex - 1 : 0
                        } label: {
                            Image("ic_arrow_left")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24, height: 24, alignment: .center)
                                .clipped()
                        }
                        .padding(10)

                        Spacer()

                        Button {
                            print("Fire")
                            let maxIdxCount = model.images.count - 1
                            currentIndex = currentIndex < maxIdxCount ? currentIndex + 1 : maxIdxCount
                        } label: {
                            Image("ic_arrow_right")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24, height: 24, alignment: .center)
                                .clipped()
                        }
                        .padding(10)
                    }
                    .padding(8)
                    .frame(height: carouselFrameHeight, alignment: .bottom)
                }
                .frame(width: geometry.size.width, height: carouselFrameHeight, alignment: .center)
            }
            .frame(width: geometry.size.width, height: carouselFrameHeight, alignment: .top)

            VStack { // Pagination
                HStack(spacing: 4) {
                    let numberFont = FontCollection.font(for: FontCollection.FancyCutProB7.bold(size: 24))
                    let numberIdx = currentIndex + 1
                    let numberIdxFormat = numberIdx > 9 ? "\(numberIdx)" : "0\(numberIdx)"

                    Text(numberIdxFormat)
                        .font(numberFont)
                        .foregroundColor(ColorCollection.black)

                    Image("ic_line_number_separator")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 21, height: 40, alignment: .center)
                        .clipped()

                    Text(model.mediaCount)
                        .accessibilityLabel(model.mediaCount)
                        .font(numberFont)
                        .foregroundColor(ColorCollection.gold)
                }
                .padding(.trailing, 40)
            }
            .frame(width: geometry.size.width, height: 40, alignment: .trailing)
        }
        .frame(width: geometry.size.width, height: 295, alignment: .center)
    }

    private func buildCarouselScrollViewStack(geometry: GeometryProxy) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            ScrollViewReader { proxy in
                LazyHStack {
                    ForEach(0..<model.images.count, id: \.self) { i in
                        let media = model.images[i]
                        Image(media.image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: geometry.size.width, height: 200, alignment: .center)
                            .clipped()
                            .tag(i)
                    }
                }
                .frame(height: 200, alignment: .center)
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
        .frame(width: geometry.size.width, height: 235, alignment: .center)
        .coordinateSpace(name: "scroll")
        .onPreferenceChange(ScrollViewOffsetKey.self) { offsetX in
//            let newIndex = Int(offsetX / UIScreen.main.bounds.width)
//            if newIndex != currentIndex {
//                currentIndex = newIndex
//            }
        }
    }

    private func buildHeaderTitleStack(geometry: GeometryProxy) -> some View {
        VStack(spacing: 8) {
            let estimatedWidth = abs(geometry.size.width - 64)
            let miniTitleFont = FontCollection.font(for: FontCollection.BrilliantCutProB7.bold(size: 11))
            Text(model.miniTitle)
                .accessibilityLabel(model.miniTitle)
                .foregroundColor(ColorCollection.black)
                .font(miniTitleFont)
                .frame(width: estimatedWidth, height: 15, alignment: .leading)

            let titleFont = FontCollection.uiFont(for: FontCollection.BrilliantCutProB7.medium(size: 28))!
            let titleHeight = model.title.constrainedSize(with: .init(width: estimatedWidth, height: .infinity), minHeight: 32, font: titleFont)
            Text(model.title)
                .accessibilityLabel(model.title)
                .foregroundColor(ColorCollection.black)
                .font(titleFont.toFont())
                .frame(width: estimatedWidth, height: titleHeight, alignment: .leading)

            VStack {
                let editionFont = FontCollection.font(for: FontCollection.BrilliantCutProB7.bold(size: 10))
                Text(model.edition)
                    .accessibilityLabel(model.edition)
                    .foregroundColor(ColorCollection.white)
                    .font(editionFont)
                    .frame(alignment: .leading)
                    .padding(8)
                    .background(ColorCollection.red)
            }
            .frame(width: estimatedWidth, height: 28, alignment: .leading)
        }
        .padding(.leading, 32)
        .padding(.trailing, 32)
        .frame(width: geometry.size.width, alignment: .leading)
    }

    private func buildInfoDetailsStack(geometry: GeometryProxy) -> some View {
        VStack {
            let estimatedWidth = abs(geometry.size.width - 64)
            let detailFont = FontCollection.uiFont(for: FontCollection.FancyCutProB7.light(size: 29))!
            let detailHeight = model.detail.constrainedSize(with: .init(width: estimatedWidth, height: .infinity), minHeight: 32, font: detailFont)

            Text(model.detail)
                .accessibilityLabel(model.detail)
                .foregroundColor(ColorCollection.black)
                .font(detailFont.toFont())
                .frame(width: estimatedWidth, height: detailHeight, alignment: .leading)

            HStack(spacing: 24) {
                VStack {
                    GeometryReader { geometry in
                        let p1 = CGPoint(x: 0, y: 0)
                        let p2 = CGPoint(x: 0, y: geometry.size.height)
                        BorderView(coordinates: [p1, p2])
                            .stroke(style: StrokeStyle(lineWidth: 1, dash: [2]))
                            .foregroundColor(ColorCollection.black)
                            .frame(width: 1, height: geometry.size.height, alignment: .leading)
                    }
                }
                .frame(width: 1, alignment: .leading)

                let estimatedWidth = estimatedWidth - 25

                VStack(spacing: 24) {
                    let titleFont = FontCollection.font(for: FontCollection.BrilliantCutProB7.bold(size: 11))
                    let detailFont = FontCollection.font(for: FontCollection.BrilliantCutProB7.medium(size: 14))

                    VStack(spacing: 8) {
                        Text("MATERIALS")
                            .accessibilityLabel("MATERIALS")
                            .foregroundColor(ColorCollection.red)
                            .font(titleFont)
                            .frame(width: estimatedWidth, alignment: .leading)

                        Text(model.materials)
                            .accessibilityLabel(model.materials)
                            .foregroundColor(ColorCollection.black)
                            .font(detailFont)
                            .frame(width: estimatedWidth, alignment: .leading)
                    }

                    VStack(spacing: 8) {
                        Text("WORLDWIDE PRICE")
                            .accessibilityLabel("WORLDWIDE PRICE")
                            .foregroundColor(ColorCollection.red)
                            .font(titleFont)
                            .frame(width: estimatedWidth, alignment: .leading)

                        Text(model.globalPrice)
                            .accessibilityLabel(model.globalPrice)
                            .foregroundColor(ColorCollection.black)
                            .font(detailFont)
                            .frame(width: estimatedWidth, alignment: .leading)
                    }
                    .frame(width: estimatedWidth, alignment: .leading)

                    VStack(spacing: 8) {
                        Text("REFERENCE")
                            .accessibilityLabel("REFERENCE")
                            .foregroundColor(ColorCollection.red)
                            .font(titleFont)
                            .frame(width: estimatedWidth, alignment: .leading)

                        Text(model.reference)
                            .accessibilityLabel(model.reference)
                            .foregroundColor(ColorCollection.black)
                            .font(detailFont)
                            .frame(width: estimatedWidth, alignment: .leading)
                    }
                    .frame(width: estimatedWidth, alignment: .leading)

                    VStack(spacing: 8) {
                        Text("LAUNCH DATE")
                            .accessibilityLabel("LAUNCH DATE")
                            .foregroundColor(ColorCollection.red)
                            .font(titleFont)
                            .frame(width: estimatedWidth, alignment: .leading)

                        Text(model.launchDate)
                            .accessibilityLabel(model.launchDate)
                            .foregroundColor(ColorCollection.black)
                            .font(detailFont)
                            .frame(width: estimatedWidth, alignment: .leading)
                    }
                    .frame(width: estimatedWidth, alignment: .leading)
                }
            }
            .padding(.top, 32)
        }
        .padding(.leading, 32)
        .padding(.trailing, 32)
        .frame(width: geometry.size.width, alignment: .leading)
    }

    private func buildProductCatalogStack(geometry: GeometryProxy) -> some View {
        Group {
            let estimatedWidth = abs(geometry.size.width - 64)
            let btnHeight: CGFloat = 54
            Button {

            } label: {
                HStack(spacing: 8) {
                    let label = "VIEW IN PRODUCT CATALOG"
                    let labelFont = FontCollection.font(for: FontCollection.BrilliantCutProB7.bold(size: 12))

                    Text(label)
                        .accessibilityLabel(label)
                        .foregroundColor(ColorCollection.black)
                        .font(labelFont)

                    Image("ic_product_catalog")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 14, height: 14, alignment: .center)
                }
                .frame(width: estimatedWidth, height: btnHeight, alignment: .center)
            }
            .frame(width: estimatedWidth, height: btnHeight, alignment: .center)
            .overlay {
                let p1 = CGPoint(x: 0, y: 0)
                let p2 = CGPoint(x: estimatedWidth, y: 0)
                let p3 = CGPoint(x: estimatedWidth, y: btnHeight)
                let p4 = CGPoint(x: 0, y: btnHeight)
                BorderView(coordinates: [p1, p2, p3, p4], shouldClosePath: true)
                    .stroke(ColorCollection.black)
            }
        }
    }

    private func buildSellingPointStack(geometry: GeometryProxy) -> some View {
        VStack {
            let titleFont = FontCollection.font(for: FontCollection.BrilliantCutProB7.bold(size: 11))
            let estimatedWidth = abs(geometry.size.width - 64)

            Text(model.sellingPointTitle)
                .accessibilityLabel(model.sellingPointTitle)
                .font(titleFont)
                .foregroundColor(ColorCollection.black)
                .frame(width: estimatedWidth, alignment: .leading)

            VStack(spacing: 24) {
                let numberFont = FontCollection.font(for: FontCollection.FancyCutCondProB7.bold(size: 44))
                let detailFont = FontCollection.uiFont(for: FontCollection.FancyCutProB7.medium(size: 18))!

                ForEach(model.sellingPoints, id: \.id) { sellingPoint in
                    HStack(spacing: 8) {
                        Text(sellingPoint.number)
                            .accessibilityLabel(sellingPoint.number)
                            .foregroundColor(ColorCollection.red)
                            .font(numberFont)
                            .frame(width: 50, alignment: .leading)

                        let estimatedWidth = estimatedWidth - 58
                        let detailHeight = sellingPoint.detail.constrainedSize(with: .init(width: estimatedWidth, height: .infinity),
                                                                               minHeight: 50,
                                                                               attributes: [.font: detailFont])
                        Text(sellingPoint.detail)
                            .accessibilityLabel(sellingPoint.detail)
                            .foregroundColor(.black)
                            .font(detailFont.toFont())
                            .frame(width: estimatedWidth, height: detailHeight, alignment: .leading)
                    }
                }
            }
            .padding(.top, 16)
            .frame(width: estimatedWidth, alignment: .leading)
        }
        .padding(.leading, 32)
        .padding(.trailing, 32)
        .frame(width: geometry.size.width, alignment: .leading)
    }
}

struct ProductPageCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            ProductPageCollectionView(geometry: geometry)
        }
    }
}


extension ProductPageCollectionView {

    static func mockData() -> Model {
        .init(miniTitle: "Panthere Collection".uppercased(),
              title: "JUSTE UN CLOU\nbracelet\ngold".uppercased(),
              edition: "LIMITED EDITION",
              images: [
                .init(id: 0, image: "img_carousel_item1"),
                .init(id: 1, image: "img_carousel_item2"),
                .init(id: 2, image: "img_carousel_item3")
              ],
              detail: "This is an optional description to describe the bracelet  of the Juste un Clou collection created by Cartier trace the outlines of a style that is both modern and daring.",
              materials: "White gold, emeralds, onyx, diamonds",
              globalPrice: "£86,500",
              reference: "N6034302",
              launchDate: "September 2015",
              sellingPoints: [
                .init(id: 1,
                      detail: "First ring made of three interlaced individual bands. Lorem ipsum dolor sit amet, consectetur adipiscing elit."),
                .init(id: 2,
                      detail: "The harmonious interplay between the bands create an expression of attachment. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex."),
                .init(id: 3,
                      detail: "Relaunched by Cartier in 1981. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.")
             ])
    }
}
