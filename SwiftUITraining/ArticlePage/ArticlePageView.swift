//
//  ArticlePageView.swift
//  SwiftUITraining
//
//  Created by Neil Francis Hipona on 3/28/22.
//

import SwiftUI

struct ArticlePageView: View {
    @Environment(\.presentationMode) private var presentationMode

    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                ArticlePageTakeAwayView(geometry: geometry)
            }
        }
        .ignoresSafeArea()
        .background(ColorCollection.white)
        .navigationBarBackButtonHidden(true)
        .navigationViewStyle(.stack)
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

extension ArticlePageView {

    static func mockTakeAwayData() -> ArticlePageTakeAwayView.Model {
        let model: ArticlePageTakeAwayView.Model = .init(miniTitle: "HISTORY",
                                                         title: "Trinity, a Mainson emblem and jewelery icon".uppercased(),
                                                         infoDate: "APR 02, 2020",
                                                         infoAuthor: "Jane Doe, Lorem Ispum Role",
                                                         infoLocation: "5th Avenue Mansion",
                                                         infoDetail: "Created in 1924 by Louis Cartier, the Trinity ring soon became one of the emblems of the Maison and a jewelery icon.",
                                                         takeAways: [
                                                            .init(id: 1,
                                                                  detail: "First ring made of three interlaced individual bands. Lorem ipsum dolor sit amet, consectetur adipiscing elit."),
                                                            .init(id: 2,
                                                                  detail: "The harmonious interplay between the bands create an expression of attachment. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex."),
                                                            .init(id: 3,
                                                                  detail: "Relaunched by Cartier in 1981. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.")
                                                         ])

        return model
    }

    static func mockTakeAwayImageData() -> ArticlePageTakeAwayView.Model {
        let model: ArticlePageTakeAwayView.Model = .init(miniTitle: "HISTORY",
                                                         title: "Trinity, a Mainson emblem and jewelery icon".uppercased(),
                                                         image: Image("img_bg_article1"),
                                                         infoDate: "APR 02, 2020",
                                                         infoAuthor: "Jane Doe, Lorem Ispum Role",
                                                         infoLocation: "5th Avenue Mansion",
                                                         infoDetail: "Created in 1924 by Louis Cartier, the Trinity ring soon became one of the emblems of the Maison and a jewelery icon.",
                                                         takeAways: [
                                                            .init(id: 1,
                                                                  detail: "First ring made of three interlaced individual bands. Lorem ipsum dolor sit amet, consectetur adipiscing elit."),
                                                            .init(id: 2,
                                                                  detail: "The harmonious interplay between the bands create an expression of attachment. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex."),
                                                            .init(id: 3,
                                                                  detail: "Relaunched by Cartier in 1981. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.")
                                                         ])

        return model
    }
}
