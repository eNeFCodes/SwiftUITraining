//
//  ProductPageView.swift
//  SwiftUITraining
//
//  Created by Neil Francis Hipona on 3/29/22.
//

import SwiftUI

struct ProductPageView: View {
    @Environment(\.presentationMode) private var presentationMode

    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                LazyVStack {
                    ProductPageCollectionView(geometry: geometry)
                    ProductPageDetailsView(geometry: geometry)
                        .padding(.top, 48)
                    ProductPageQuotedView(geometry: geometry)
                        .padding(.top, 48)

                    let item = SearchPageView.Searched(id: 0,
                                                       title: "panthere".uppercased(),
                                                       subTitle: "The History of the Cartier Panthère Bracelet".uppercased(),
                                                       imageName: "img_result4",
                                                       date: "MAR. 1, 2020")
                    SearchResultItemView(geometry: geometry, item: item, sidePadding: 32) { item in
                        print("tapped: ", item)
                    }
                    .padding(.top, 48)
                }
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

struct ProductPageView_Previews: PreviewProvider {
    static var previews: some View {
        ProductPageView()
    }
}
