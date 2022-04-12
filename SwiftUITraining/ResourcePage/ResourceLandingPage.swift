//
//  ResourceLandingPage.swift
//  SwiftUITraining
//
//  Created by Neil Francis Hipona on 4/8/22.
//

import SwiftUI

struct ResourceLandingPage: View {

    @StateObject var model: ResourceLandingPageModel = ResourceLandingPage.mockData()

    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 40) {
                    ResourceLandingTitleView(geometry: geometry, model: model.titleModel)

                    TagView(geometry: geometry, alignment: .leading, model: model.tagsModel)

                    LazyVStack(spacing: 40) {
                        ForEach(model.reportsModel, id: \.id) { model in
                            ResourceReportView(geometry: geometry, model: model)
                        }
                    }
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

extension ResourceLandingPage {

    static func mockData() -> ResourceLandingPageModel {
        .init(titleModel: ResourceLandingTitleView.mockData(),
              tagsModel: TagView.mockData(),
              reportsModel: [
                .init(id: 0,
                      shortTitle: "RESOURCE TYPE",
                      longTitle: "Repair Creation and Follow-up".uppercased(),
                      message: "Nam ultrices dictum nunc at tempus. Praesent bibendum tellus tellus, quis fringilla quam convallis sed lorem ipsum longer sentence bla bla something else.",
                      attachment: "PDF / 3.83 MB"),
                .init(id: 1,
                      shortTitle: "RESOURCE TYPE",
                      longTitle: "COMMISSIONS TO INTERMEDIARIES".uppercased(),
                      message: "Nam ultrices dictum nunc at tempus. Praesent bibendum tellus tellus, quis fringilla quam convallis sed lorem ipsum longer sentence bla bla something else."),
                .init(id: 2,
                      shortTitle: "RESOURCE TYPE",
                      longTitle: "GUARANTEE AND AUTHENTICITY CERTIFICATES".uppercased(),
                      message: "Nam ultrices dictum nunc at tempus. Praesent bibendum tellus tellus, quis fringilla quam convallis sed lorem ipsum longer sentence bla bla something else.",
                      attachment: "PDF / 3.83 MB")
              ])
    }
}
