//
//  BriefingNeedToKnowView.swift
//  SwiftUITraining
//
//  Created by Neil Francis Hipona on 4/4/22.
//

import SwiftUI

extension BriefingNeedToKnowView {
    struct Model {
        struct KnowInfo: Identifiable {
            let id: Int
            let title: String
            let message: String
            let icon: String
        }

        let title: String
        let knowTos: [KnowInfo]
    }
}

struct BriefingNeedToKnowView: View {

    let geometry: GeometryProxy
    let model: Model = BriefingNeedToKnowView.mockData()
    @State private var currentIndex: Int = 0

    var body: some View {
        ZStack {
            buildTitleViewStack(geometry: geometry)
            buildKnowInfoViewStack(geometry: geometry)
                .padding(.top, 86)
        }
        .frame(width: geometry.size.width, height: 485, alignment: .center)
    }

    private func buildTitleViewStack(geometry: GeometryProxy) -> some View {
        VStack {
            let sidePadding: CGFloat = 32
            let redBGViewWidth = abs(geometry.size.width - 85)
            VStack {
                let titleFieldWidth = redBGViewWidth - sidePadding
                let titleFont = FontCollection.font(for: FontCollection.FancyCutCondProB7.bold(size: 30))
                Text(model.title)
                    .accessibilityLabel(model.title)
                    .font(titleFont)
                    .foregroundColor(ColorCollection.white)
                    .padding(.top, sidePadding)
                    .frame(width: titleFieldWidth, alignment: .leading)
                Spacer()
            }
            .padding(.leading, sidePadding)
            .frame(width: redBGViewWidth, height: 412, alignment: .leading)
            .background(ColorCollection.red)
            .mask {
                GeometryReader { geometry in
                    let curve: CGFloat = 20
                    let width = geometry.size.width
                    let height = geometry.size.height

                    let p1 = CGPoint(x: 0, y: 0)
                    let p2 = CGPoint(x: width - curve, y: 0)
                    let p3 = CGPoint(x: width, y: curve)
                    let p4 = CGPoint(x: width, y: height)
                    let p5 = CGPoint(x: 0, y: height)
                    BorderView(coordinates: [p1, p2, p3, p4, p5], shouldClosePath: true)
                }
            }
            Spacer()
        }
        .frame(width: geometry.size.width, alignment: .leading)
    }

    private func buildKnowInfoViewStack(geometry: GeometryProxy, maxHeight: CGFloat = 399) -> some View {
        VStack {
            Spacer()
            let sidePadding: CGFloat = 32
            let itemWidth = abs(geometry.size.width - (sidePadding * 2))
            ScrollView(.horizontal, showsIndicators: false) {
                ScrollViewReader { proxy in
                    LazyHStack(spacing: 12) {
                        let maxKnowTosIndexCount = model.knowTos.count - 1
                        ForEach(0...maxKnowTosIndexCount, id: \.self) { i in
                            let item = model.knowTos[i]
                            let leftPadding = i == 0 ? sidePadding : 0
                            let rightPadding = i == maxKnowTosIndexCount ? sidePadding : 0
                            builKnowInfoItemViewStack(itemWidth: itemWidth, maxHeight: maxHeight, item: item, tag: i)
                                .padding(.leading, leftPadding)
                                .padding(.trailing, rightPadding)
                        }
                    }
                    .frame(height: maxHeight, alignment: .center)
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
            .frame(width: geometry.size.width, height: maxHeight, alignment: .center)
            .coordinateSpace(name: "scroll")
        }
        .frame(width: geometry.size.width, height: maxHeight, alignment: .center)
    }

    private func builKnowInfoItemViewStack(itemWidth: CGFloat, maxHeight: CGFloat, item: BriefingNeedToKnowView.Model.KnowInfo, tag i: Int) -> some View {
        ZStack {
            let sidePadding: CGFloat = 30
            VStack {
                Spacer()
                Image("img_ftue_bottom_bg")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: itemWidth, height: 143, alignment: .top)
                    .clipped()
            }

            VStack(spacing: 0) {
                Image(item.icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 74, height: 74, alignment: .center)
                    .clipped()
                    .padding(.top, 20)

                let titleFont = FontCollection.font(for: FontCollection.BrilliantCutProB7.medium(size: 22))
                Text(item.title)
                    .accessibilityLabel(item.title)
                    .foregroundColor(ColorCollection.white)
                    .font(titleFont)
                    .padding(.top, 20)
                    .multilineTextAlignment(.center)

                let p1 = CGPoint(x: 0, y: 0)
                let p2 = CGPoint(x: 0, y: 60)
                BorderView(coordinates: [p1, p2])
                    .stroke(style: StrokeStyle(lineWidth: 1, dash: [2]))
                    .frame(width: 1, height: 60, alignment: .center)
                    .foregroundColor(ColorCollection.gold)
                    .padding(.top, sidePadding)
                    .padding(.bottom, sidePadding)

                let messageFont = FontCollection.font(for: FontCollection.BrilliantCutProB7.bold(size: 11))
                Text(item.message)
                    .accessibilityLabel(item.message)
                    .foregroundColor(ColorCollection.white)
                    .font(messageFont)
                    .multilineTextAlignment(.center)

                Image("ic_3arrow_red")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 43, height: 12, alignment: .center)
                    .padding(.top, 10)
            }
            .padding(.leading, sidePadding)
            .padding(.trailing, sidePadding)
            .frame(width: itemWidth, height: maxHeight, alignment: .center)
        }
        .frame(width: itemWidth, height: maxHeight, alignment: .center)
        .background(ColorCollection.black)
        .tag(i)
    }
}

struct BriefingNeedToKnowView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            BriefingNeedToKnowView(geometry: geometry)
        }
    }
}

extension BriefingNeedToKnowView {
    static func mockData() -> BriefingNeedToKnowView.Model {
        .init(title: "YOUR BOUTIQUE",
              knowTos: [
                .init(id: 0,
                      title: "1 here are the key things you need to know today!".uppercased(),
                      message: "Swipe left to get started".uppercased(),
                      icon: "ic_knowTo1"),
                .init(id: 1,
                      title: "2 here are the key things you need to know today!".uppercased(),
                      message: "Swipe left to get started".uppercased(),
                      icon: "ic_knowTo1"),
                .init(id: 3,
                      title: "3 here are the key things you need to know today!".uppercased(),
                      message: "Swipe left to get started".uppercased(),
                      icon: "ic_knowTo1"),
                .init(id: 4,
                      title: "4 here are the key things you need to know today!".uppercased(),
                      message: "Swipe left to get started".uppercased(),
                      icon: "ic_knowTo1"),
                .init(id: 5,
                      title: "5 here are the key things you need to know today!".uppercased(),
                      message: "Swipe left to get started".uppercased(),
                      icon: "ic_knowTo1")
              ])
    }
}
