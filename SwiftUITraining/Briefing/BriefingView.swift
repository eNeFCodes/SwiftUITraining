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

                    let btn1 = BriefingNavView.ButtonItem(id: 0,
                                                          icon: Image("ic_star"),
                                                          title: "A LA UNE",
                                                          titleColor: .black,
                                                          bgColor: .white,
                                                          strokeColor: .black) {
                        print("btn1")
                    }
                    let btn2 = BriefingNavView.ButtonItem(id: 1,
                                                          icon: Image("ic_eye_white"),
                                                          bgColor: .black,
                                                          strokeColor: .white) {
                        print("btn2")
                    }
                    let btn3 = BriefingNavView.ButtonItem(id: 2,
                                                          icon: Image("ic_resource_white"),
                                                          bgColor: .black,
                                                          strokeColor: .white) {
                        print("btn3")
                    }
                    let btn4 = BriefingNavView.ButtonItem(id: 3,
                                                          icon: Image("ic_plus"),
                                                          bgColor: .orange,
                                                          strokeColor: .black) {
                        print("btn4")
                    }

                    BriefingNavView(buttons: [btn1, btn2, btn3, btn4])
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
