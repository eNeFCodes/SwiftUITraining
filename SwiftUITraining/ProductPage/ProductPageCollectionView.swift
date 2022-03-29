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

        let miniTitle: String
        let title: String
        let edition: String
        let images: [Media]

        var mediaCount: String {
            return images.count > 9 ? "\(images.count)" : "0\(images.count)"
        }
    }
}

struct ProductPageCollectionView: View {

    let model: Model = ProductPageCollectionView.mockData()

    var body: some View {
        VStack {
            GeometryReader { geometry in
                headerCarousel(geometry: geometry)
            }
            .frame(height: 295, alignment: .center)
        }
        .padding(.top, 91)
    }

    private func headerCarousel(geometry: GeometryProxy) -> some View { // 295pt
        Group { // Header
            ZStack { // Carousel
                Group {
                    VStack { // Backdrop
                        VStack {}
                        .frame(width: 299, height: 181, alignment: .top)
                        .background(Color.init(hex: "C10016"))
                        Spacer()
                    }
                    .frame(width: geometry.size.width, height: 235, alignment: .trailing)

                    VStack {
                        let borderFrameSize = CGSize(width: 288, height: 174)
                        HStack(spacing: 12) {
                            let arrowBotPadding: CGFloat = 18

                            Spacer()
                            VStack {
                                Button {
                                    print("ADD ACTION HERE")
                                } label: {
                                    Image("ic_arrow_left")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 24, height: 24, alignment: .center)
                                        .clipped()
                                }
                            }
                            .frame(height: borderFrameSize.height, alignment: .bottom)
                            .padding(.bottom, arrowBotPadding)
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
                                    .stroke(Color.init(hex: "AC9852"))
                                    .frame(width: borderFrameSize.width, height: borderFrameSize.height, alignment: .center)
                            }
                            Spacer()
                            VStack {
                                Button {
                                    print("ADD ACTION HERE")
                                } label: {
                                    Image("ic_arrow_right")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 24, height: 24, alignment: .center)
                                        .clipped()
                                }
                            }
                            .frame(height: borderFrameSize.height, alignment: .bottom)
                            .padding(.bottom, arrowBotPadding)
                            Spacer()
                        }
                        .frame(width: geometry.size.width, height: borderFrameSize.height, alignment: .bottom)
                    }
                    .frame(width: geometry.size.width, height: 235, alignment: .bottom)
                }
                .frame(width: geometry.size.width, height: 235, alignment: .center)

                Group {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(0..<model.images.count) { i in
                                let media = model.images[i]
                                Image(media.image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geometry.size.width, height: 200, alignment: .center)
                                    .clipped()
                            }
                        }
                        .frame(height: 200, alignment: .center)
                    }
                    .frame(width: geometry.size.width, height: 235, alignment: .center)
                }
                .frame(width: geometry.size.width, height: 235, alignment: .center)
            }
            .frame(width: geometry.size.width, height: 235, alignment: .top)

            VStack { // Pagination
                HStack(spacing: 4) {
                    let numberFont = Font.custom("FancyCutProB7-Bold", size: 24)

                    Text("01")
                        .font(numberFont)
                        .foregroundColor(Color.init(hex: "0D0D0D"))

                    Image("ic_line_number_separator")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 21, height: 40, alignment: .center)
                        .clipped()

                    Text(model.mediaCount)
                        .accessibilityLabel(model.mediaCount)
                        .font(numberFont)
                        .foregroundColor(Color.init(hex: "AC9852"))
                }
                .padding(.trailing, 40)
            }
            .frame(width: geometry.size.width, height: 40, alignment: .trailing)
            .padding(.top, 255)
        }
    }
}

struct ProductPageCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        ProductPageCollectionView()
    }
}


extension ProductPageCollectionView {

    static func mockData() -> Model {
        .init(miniTitle: "Panthere Collection".uppercased(),
              title: "JUSTE UN CLOU bracelet gold".uppercased(),
              edition: "LIMITED EDITION",
              images: [
                .init(id: 0, image: "img_carousel_item1"),
                .init(id: 1, image: "img_carousel_item1"),
                .init(id: 2, image: "img_carousel_item1")
              ])
    }
}
