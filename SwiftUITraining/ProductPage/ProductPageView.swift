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
        ScrollView(.vertical) {
            ProductPageCollectionView()
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
