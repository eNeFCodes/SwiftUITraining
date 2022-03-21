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
            ScrollView {
                Image("img_briefing_content")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: abs(geometry.size.width), alignment: .center)
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
