//
//  BriefingView.swift
//  SwiftUITraining
//
//  Created by Neil Francis Hipona on 3/21/22.
//

import SwiftUI

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

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ScrollView {
                    Image("img_briefing_content")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: abs(geometry.size.width), alignment: .center)
                }

                VStack {
                    Spacer()
                    
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

            NavigationLink("", isActive: $isSearchPageActive) {
                SearchPageView()
            }
        }
        .padding(.top, 20)
        .ignoresSafeArea()
        .background(Color.white)
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}

struct BriefingView_Previews: PreviewProvider {
    static var previews: some View {
        BriefingView()
    }
}
