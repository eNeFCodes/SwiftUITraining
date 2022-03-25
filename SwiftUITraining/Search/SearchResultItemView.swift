//
//  SearchResultItemView.swift
//  SwiftUITraining
//
//  Created by Neil Francis Hipona on 3/25/22.
//

import SwiftUI

struct SearchResultItemView: View {

    let image: Image
    let title: String
    let subTitle: String
    let date: String
    let action: () -> Void

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 8) {
                let paddedWidth = geometry.size.width - 40
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: paddedWidth, height: paddedWidth, alignment: .center)

                let titleFont = Font.custom("BrilliantCutProB7-Bold", size: 11)
                Text(title)
                    .accessibilityLabel(title)
                    .font(titleFont)
                    .frame(width: paddedWidth, alignment: .leading)
                    .padding(.top, 16)

                HStack(alignment: .top, spacing: 10) {
                    VStack(alignment: .trailing) {
                        let subTitleFont = Font.custom("BrilliantCutProB7-Bold", size: 22)
                        Text(subTitle)
                            .accessibilityLabel(subTitle)
                            .font(subTitleFont)
                            .multilineTextAlignment(.leading)
                    }
                    Spacer()
                    VStack(alignment: .trailing) {
                        Button {

                        } label: {
                            Image("ic_bookmark")
                                .resizable()
                                .frame(width: 24, height: 24, alignment: .center)
                        }
                    }
                }
                .frame(minHeight: 30, idealHeight: 30, maxHeight: 96, alignment: .top)

                let dateFont = Font.custom("BrilliantCutProB7-Bold", size: 12)
                Text(date)
                    .accessibilityLabel(date)
                    .font(dateFont)
                    .frame(width: paddedWidth, alignment: .leading)

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

struct SearchResultItemView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultItemView(image: Image("img_result1"),
                             title: "PANTHERE",
                             subTitle: "JUSTE sedfsa Vehicula Etiam Egestas lorem ipsum",
                             date: "MAR. 1, 2020") {
        }
    }
}
