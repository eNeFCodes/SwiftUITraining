//
//  BriefingView.swift
//  SwiftUITraining
//
//  Created by Neil Francis Hipona on 3/21/22.
//

import SwiftUI

struct BriefingView: View {
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
                        print("btn1")
                    }
                    let btn2 = NavigationButtonItem(id: 1,
                                                    icon: Image("ic_eye_white"),
                                                    activeIcon: Image("ic_eye"),
                                                    title: "LIVE") {
                        print("btn2")
                    }
                    let btn3 = NavigationButtonItem(id: 2,
                                                    icon: Image("ic_resource_white"),
                                                    activeIcon: Image("ic_resource"),
                                                    title: "RESOURCES") {
                        print("btn3")
                    }
                    let btn4 = NavigationButtonItem(id: 3,
                                                    icon: Image("ic_plus"),
                                                    activeIcon: Image("ic_plus"),
                                                    title: "ADD",
                                                    bgColor: .orange) {
                        print("btn4")
                    }

                    NavigationButtonView(buttons: [btn1, btn2, btn3, btn4])
                        .padding(.bottom, 40)
                }
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
