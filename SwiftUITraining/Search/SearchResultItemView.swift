//
//  SearchResultItemView.swift
//  SwiftUITraining
//
//  Created by Neil Francis Hipona on 3/25/22.
//

import SwiftUI

struct SearchResultItemView: View {

    let geometry: GeometryProxy
    let item: SearchPageView.Searched
    var sidePadding: CGFloat = 20
    var showSeparator: Bool = true
    let action: (_ item: SearchPageView.Searched) -> Void

    var body: some View {
        VStack(spacing: 8) {
            let paddedWidth = abs(geometry.size.width - (sidePadding * 2))
            Image(item.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: paddedWidth, height: paddedWidth, alignment: .center)
                .clipped()

            let titleFont = FontCollection.uiFont(for: FontCollection.BrilliantCutProB7.bold(size: 11))!
            let titleHeight = item.title.constrainedSize(with: .init(width: paddedWidth, height: .infinity),
                                                         minHeight: 15,
                                                         font: titleFont)
            Text(item.title)
                .accessibilityLabel(item.title)
                .font(titleFont.toFont())
                .frame(width: paddedWidth, height: titleHeight, alignment: .leading)
                .padding(.top, 16)

            HStack(alignment: .top, spacing: 10) {
                VStack(alignment: .leading) {
                    let subTitleFont = FontCollection.uiFont(for: FontCollection.BrilliantCutProB7.bold(size: 22))!
                    let subTitleFieldViewWidth = paddedWidth - 34
                    let subTitleHeight = item.subTitle.constrainedSize(with: .init(width: subTitleFieldViewWidth, height: .infinity),
                                                                       minHeight: 24,
                                                                       font: subTitleFont)
                    Text(item.subTitle)
                        .accessibilityLabel(item.subTitle)
                        .font(subTitleFont.toFont())
                        .frame(width: subTitleFieldViewWidth, height: subTitleHeight, alignment: .leading)
                }
                VStack(alignment: .trailing) {
                    Button {
                        action(item)
                    } label: {
                        Image("ic_bookmark")
                            .resizable()
                            .frame(width: 24, height: 24, alignment: .center)
                    }
                }
            }
            .frame(width: paddedWidth, alignment: .top)

            let dateFont = FontCollection.font(for: FontCollection.BrilliantCutProB7.bold(size: 12))
            Text(item.date)
                .accessibilityLabel(item.date)
                .font(dateFont)
                .frame(width: paddedWidth, height: 15, alignment: .leading)

            if showSeparator {
                VStack {
                    let p1 = CGPoint(x: 0, y: 0)
                    let p2 = CGPoint(x: paddedWidth, y: 0)
                    BorderView(coordinates: [p1, p2])
                        .stroke(style: StrokeStyle(lineWidth: 1, lineCap: .round, dash: [2]))
                        .foregroundColor(Color.init(hex: "DCD7CA"))
                }
                .frame(width: paddedWidth, height: 1, alignment: .center)
                .padding(.top, 16)
            }
        }
        .multilineTextAlignment(.leading)
        .padding(.leading, sidePadding)
        .padding(.trailing, sidePadding)
        .frame(width: abs(geometry.size.width), alignment: .leading)
    }
}

extension SearchResultItemView {

    static func calculatedHeight(geometry: GeometryProxy) -> CGFloat {
        let paddedWidth = geometry.size.width - 40
        let finalHeight = 231 + paddedWidth
        return finalHeight
    }
}

struct SearchResultItemView_Previews: PreviewProvider {
    static let item = SearchPageView.Searched(id: 0,
                               title: "PANTHERE",
                               subTitle: "JUSTE sedfsa Vehicula Etiam Egestas lorem ipsum",
                               imageName: "img_result1",
                               date: "May 1, 2020")
    static var previews: some View {
        GeometryReader { geometry in
            SearchResultItemView(geometry: geometry, item: item) { item in
                print("item: ", item)
            }
        }
    }
}
