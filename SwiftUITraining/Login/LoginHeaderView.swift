//
//  LoginHeaderView.swift
//  SwiftUITraining
//
//  Created by Neil Francis Hipona on 3/7/22.
//

import SwiftUI

struct LoginHeaderView: View {
    var geometry: GeometryProxy
    
    var body: some View {
        ZStack {
            HStack {
                let frameSize = CGSize(width: geometry.size.width - 80, height: 180)
                let font = Font.custom("FancyCutCondProB7-Bold", size: 50)
                Text("CNT\nJEWERLY")
                    .font(font)
                    .foregroundColor(.white)
                    .frame(width: abs(frameSize.width),
                           height: frameSize.height,
                           alignment: .leading)
                    .padding(.leading, 20)
                    .overlay {
                        let rect = CGRect(x: 0, y: 0,
                                          width: frameSize.width, height: frameSize.height)

                        let p1 = CGPoint(x: 0, y: 0)
                        let p2 = CGPoint(x: rect.width - 20, y: 0)
                        let p3 = CGPoint(x: rect.width, y: 20)
                        let p4 = CGPoint(x: rect.width, y: rect.height - 20)
                        let p5 = CGPoint(x: rect.width - 20, y: rect.height)
                        let p6 = CGPoint(x: 0, y: rect.height)

                        BorderView(coordinates: [p1, p2, p3, p4, p5, p6])
                            .stroke(Color.yellow, lineWidth: 2)
                    }
                Spacer()
            }
            .padding(.top, 60)

            HStack {
                Spacer()
                Image("ic_logo")
                    .clipped()
                    .frame(width: 200,
                           height: 200,
                           alignment: .trailing)
            }
            .offset(y: 100)
        }
    }
}

struct LoginHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            LoginHeaderView(geometry: geometry)
        }
    }
}
