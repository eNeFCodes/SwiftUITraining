//
//  ArticlePageView.swift
//  SwiftUITraining
//
//  Created by Neil Francis Hipona on 3/25/22.
//

import SwiftUI

struct ArticlePageView: View {

    @Environment(\.presentationMode) private var presentationMode

    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 18) {
                // title stack
                VStack(alignment: .leading, spacing: 8) {
                    let miniTitleFont = Font.custom("BrilliantCutProB7-Bold", size: 11)
                    let miniTitleString = "HISTORY"
                    Text(miniTitleString)
                        .accessibilityLabel(miniTitleString)
                        .font(miniTitleFont)
                        .foregroundColor(.black)

                    let titleFont = Font.custom("BrilliantCutProB7-Bold", size: 28)
                    let titleString = "Trinity, a Mainson emblem and jewelery icon".uppercased()
                    Text(titleString)
                        .accessibilityLabel(titleString)
                        .font(titleFont)
                        .foregroundColor(.black)
                }

                // detail stack
                HStack(alignment: .top, spacing: 24) {
                    VStack {
                        GeometryReader { geometry in
                            let p1 = CGPoint(x: 0, y: 0)
                            let p2 = CGPoint(x: 0, y: geometry.size.height)
                            BorderView(coordinates: [p1, p2])
                                .stroke(style: StrokeStyle(lineWidth: 1, dash: [2]))
                                .foregroundColor(Color.init(hex: "AC9852"))
                                .frame(width: 1, height: geometry.size.height, alignment: .leading)
                        }
                    }
                    .frame(width: 1, alignment: .leading)

                    VStack(alignment: .leading, spacing: 8) {
                        let miniTitleFont = Font.custom("FancyCutProB7-Bold", size: 11)
                        let miniTitleString = "HISTORY"
                        Text(miniTitleString)
                            .accessibilityLabel(miniTitleString)
                            .font(miniTitleFont)
                            .foregroundColor(.black)

                        let titleFont = Font.custom("FancyCutProB7-Bold", size: 29)
                        let titleString = "Trinity, a Mainson emblem and jewelery icon".uppercased()
                        Text(titleString)
                            .accessibilityLabel(titleString)
                            .font(titleFont)
                            .foregroundColor(.black)
                    }
                }
                .frame(minHeight: 20, alignment: .center)
            }
            .padding(20)
            .frame(width: abs(geometry.size.width))
            .background(Color.init(hex: "DCD7CA"))
        }
        .background(Color.black)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Image("ic_arrow_left_black")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 44, height: 21, alignment: .center)
        }), trailing: Button(action: {
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Image("ic_nav_bookmark_black")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 32, height: 32, alignment: .center)
        }))
    }
}

struct ArticlePageView_Previews: PreviewProvider {
    static var previews: some View {
        ArticlePageView()
    }
}
