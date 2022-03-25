//
//  SearchResultItemView.swift
//  SwiftUITraining
//
//  Created by Neil Francis Hipona on 3/25/22.
//

import SwiftUI

struct SearchResultItemView: View {

    let item: SearchPageView.Searched
    let action: (_ item: SearchPageView.Searched) -> Void

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 8) {
                let paddedWidth = geometry.size.width - 40
                Image(item.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: paddedWidth, height: paddedWidth, alignment: .center)

                let titleFont = Font.custom("BrilliantCutProB7-Bold", size: 11)
                Text(item.title)
                    .accessibilityLabel(item.title)
                    .font(titleFont)
                    .frame(width: paddedWidth, height: 15, alignment: .leading)
                    .padding(.top, 16)

                HStack(alignment: .top, spacing: 10) {
                    VStack(alignment: .trailing) {
                        let subTitleFont = Font.custom("BrilliantCutProB7-Bold", size: 22)
                        Text(item.subTitle)
                            .accessibilityLabel(item.subTitle)
                            .font(subTitleFont)
                            .multilineTextAlignment(.leading)
                    }
                    Spacer()
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
                .frame(minHeight: 30, idealHeight: 30, maxHeight: 96, alignment: .top)

                let dateFont = Font.custom("BrilliantCutProB7-Bold", size: 12)
                Text(item.date)
                    .accessibilityLabel(item.date)
                    .font(dateFont)
                    .frame(width: paddedWidth, height: 15, alignment: .leading)

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
            .multilineTextAlignment(.leading)
            .padding(20)
            .frame(width: abs(geometry.size.width), alignment: .leading)
        }
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
        SearchResultItemView(item: item) { item in
            print("item: ", item)
        }
    }
}
