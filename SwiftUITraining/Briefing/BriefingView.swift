//
//  BriefingView.swift
//  SwiftUITraining
//
//  Created by Neil Francis Hipona on 3/21/22.
//

import SwiftUI

extension BriefingView {
    struct Model {
        let bonjurDate: String
        let bonjurTitle: String
    }
}

struct BriefingView: View {

    private enum NavType {
        case star
        case live
        case resource
        case add
    }

    @State private var navType: NavType = .star {
        didSet {
            switch navType {
            case .add:
                isSearchPageActive = true
            default:
                isSearchPageActive = false
            }
        }
    }
    @State private var isSearchPageActive: Bool = false
    @EnvironmentObject private var appEnv: AppEnv

    let model: Model = BriefingView.mockData()

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ScrollView {
                    buildTopNavigationViewStack(geometry: geometry)
                        .padding(.top, 25)

                    buildBonjurViewStack(geometry: geometry)
                        .padding(.top, 26)

                    
                }

                VStack {
                    Spacer()
                    buildFloatingNavigationViewStack()
                }
            }

            NavigationLink("", isActive: $isSearchPageActive) {
                SearchPageView()
            }
        }
        .padding(.top, 20)
        .ignoresSafeArea()
        .background(ColorCollection.white)
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }

    private func buildTopNavigationViewStack(geometry: GeometryProxy) -> some View {
        BriefingNavigationView(title: "CNT",
                               subTitle: "JEWELRY",
                               geometry: geometry,
                               sidePadding: 32) {
            print("Trigger Nav Search")
        } btnProfileAction: {
            print("Trigger Nav Profile")
        }
    }

    private func buildBonjurViewStack(geometry: GeometryProxy) -> some View {
        Group {
            let sidePadding: CGFloat = 32
            VStack(spacing: 8) {
                let textContentWidth = abs(geometry.size.width - (sidePadding * 2))
                let dateFont = FontCollection.font(for: FontCollection.BrilliantCutProB7.regular(size: 11))
                Text(model.bonjurDate)
                    .accessibilityLabel(model.bonjurDate)
                    .font(dateFont)
                    .frame(width: textContentWidth, alignment: .leading)

                let bonjurFont = FontCollection.font(for: FontCollection.BrilliantCutProB7.bold(size: 28))
                Text(model.bonjurTitle)
                    .accessibilityLabel(model.bonjurTitle)
                    .font(bonjurFont)
                    .frame(width: textContentWidth, alignment: .leading)
            }
            .foregroundColor(ColorCollection.black)
            .padding(.leading, sidePadding)
            .padding(.trailing, sidePadding)
            .frame(width: abs(geometry.size.width), alignment: .leading)
        }
    }

    private func buildFloatingNavigationViewStack() -> some View {
        Group {
            let btn1 = NavigationButtonItem(id: 0,
                                            icon: Image("ic_star_white"),
                                            activeIcon: Image("ic_star"),
                                            title: "A LA UNE",
                                            isActive: true) {
                navType = .star
            }
            let btn2 = NavigationButtonItem(id: 1,
                                            icon: Image("ic_eye_white"),
                                            activeIcon: Image("ic_eye"),
                                            title: "LIVE") {
                navType = .live
            }
            let btn3 = NavigationButtonItem(id: 2,
                                            icon: Image("ic_resource_white"),
                                            activeIcon: Image("ic_resource"),
                                            title: "RESOURCES") {
                navType = .resource
            }
            let btn4 = NavigationButtonItem(id: 3,
                                            icon: Image("ic_plus"),
                                            activeIcon: Image("ic_plus"),
                                            title: "ADD",
                                            bgColor: .orange) {
                navType = .add
            }

            NavigationButtonView(buttons: [btn1, btn2, btn3, btn4])
                .padding(.bottom, 40)
        }
    }
}

struct BriefingView_Previews: PreviewProvider {
    static var previews: some View {
        BriefingView()
    }
}

extension BriefingView {
    static func mockData() -> BriefingView.Model {
        .init(bonjurDate: "Monday, Nov 18, 2019",
              bonjurTitle: "Bonjour,\nJean!".uppercased())
    }
}
