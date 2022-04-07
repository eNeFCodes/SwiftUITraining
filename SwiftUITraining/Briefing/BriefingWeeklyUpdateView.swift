//
//  BriefingWeeklyUpdateView.swift
//  SwiftUITraining
//
//  Created by Neil Francis Hipona on 4/5/22.
//

import SwiftUI

extension BriefingWeeklyUpdateView {
    struct Model {
        let title: String
        let product: SearchPageView.Searched
    }
}

struct BriefingWeeklyUpdateView: View {
    let geometry: GeometryProxy
    let model: Model = BriefingWeeklyUpdateView.mockData()

    var body: some View {
        ZStack {
            VStack {
                buildBackDropTitleViewStack(geometry: geometry)
                Spacer()
            }

            VStack(spacing: 32) {
                SearchResultItemView(geometry: geometry, item: model.product, sidePadding: 32) { item in
                    print("item: ", item)
                }

                SearchResultItemView(geometry: geometry, item: model.product, sidePadding: 32) { item in
                    print("item: ", item)
                }

                BriefingStandardProductView(geometry: geometry, model: BriefingStandardProductView.mockData())

                SearchResultItemView(geometry: geometry, item: model.product, sidePadding: 32) { item in
                    print("item: ", item)
                }

                BriefingStandardProductDetailsOnlyView(geometry: geometry, model: BriefingStandardProductDetailsOnlyView.mockData())

                ProductPageOverlayedView(geometry: geometry, model: ProductPageOverlayedView.mockData2())
                Spacer()
            }
            .padding(.top, 130)
        }
    }

    private func buildBackDropTitleViewStack(geometry: GeometryProxy) -> some View {
        Group {
            let frameWidth = abs(geometry.size.width)
            let frameHeight: CGFloat = 236
            ZStack {
                VStack {
                    Spacer()
                    Image("img_bg_article")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: frameWidth, height: 143, alignment: .top)
                        .clipped()
                }
                .frame(width: frameWidth, height: frameHeight, alignment: .center)

                VStack {
                    let redBGViewWidth = abs(frameWidth - 85)
                    let sidePadding: CGFloat = 32
                    VStack {
                        let titleFont = FontCollection.font(for: FontCollection.FancyCutCondProB7.bold(size: 30))
                        let titleString = "This week\naround CNT".uppercased()

                        Text(titleString)
                            .accessibilityLabel(titleString)
                            .foregroundColor(ColorCollection.white)
                            .font(titleFont)
                            .multilineTextAlignment(.trailing)
                    }
                    .padding(.top, sidePadding)
                    .padding(.leading, sidePadding)
                    .padding(.trailing, sidePadding)
                    .frame(width: redBGViewWidth, height: frameHeight, alignment: .topTrailing)
                    .background(ColorCollection.red)
                    .mask {
                        GeometryReader { geometry in
                            let curve: CGFloat = 20
                            let p1 = CGPoint(x: curve, y: 0)
                            let p2 = CGPoint(x: geometry.size.width, y: 0)
                            let p3 = CGPoint(x: geometry.size.width, y: geometry.size.height)
                            let p4 = CGPoint(x: 0, y: geometry.size.height)
                            let p5 = CGPoint(x: 0, y: curve)
                            BorderView(coordinates: [p1, p2, p3, p4, p5], shouldClosePath: true)
                        }
                    }
                }
                .frame(width: frameWidth, height: frameHeight, alignment: .trailing)
            }
            .frame(width: frameWidth, height: frameHeight, alignment: .center)
        }
    }
}

struct BriefingWeeklyUpdateView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            BriefingWeeklyUpdateView(geometry: geometry)
        }
    }
}

extension BriefingWeeklyUpdateView {
    static func mockData() -> BriefingWeeklyUpdateView.Model {
        .init(title: "THIS WEEK\nAROUND CNT",
              product: .init(id: 0,
                             title: "panthere".uppercased(),
                             subTitle: "The History of the Cartier Panthère Bracelet".uppercased(),
                             imageName: "img_result4",
                             date: "MAR. 1, 2020"))
    }
}
