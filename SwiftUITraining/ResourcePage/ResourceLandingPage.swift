//
//  ResourceLandingPage.swift
//  SwiftUITraining
//
//  Created by Neil Francis Hipona on 4/8/22.
//

import SwiftUI

struct ResourceLandingPage: View {
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 40) {
                    ResourceLandingTitleView(geometry: geometry, model: ResourceLandingTitleView.mockData())

                    TagView(geometry: geometry, alignment: .leading, model: TagView.mockData())
                }
            }
            
            VStack {
                ResourceNavigationView(geometry: geometry, model: navModel())
                Spacer()
            }
            .padding(.top, 50)
        }
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }

    private func navModel() -> ResourceNavigationViewModel {
        ResourceNavigationViewModel(title: "CNT",
                                    subTitle: "JEWELRY",
                                    logo: "ic_cartier_logo") {

        } btnProfileAction: {

        }
    }
}

struct ResourceLandingPage_Previews: PreviewProvider {
    static var previews: some View {
        ResourceLandingPage()
    }
}
