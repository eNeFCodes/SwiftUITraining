//
//  LoaderView.swift
//  SwiftUITraining
//
//  Created by Neil Francis Hipona on 3/4/22.
//

import SwiftUI

struct LoaderView<Content: View>: View {
    var title: String = "Loading..."
    var content: (_ geometry: GeometryProxy) -> Content
    @Binding var isLoading: Bool

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                content(geometry)
                    .disabled(isLoading)
                    .blur(radius: isLoading ? 3 : 0)

                VStack {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.white)
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                }
                .frame(width: geometry.size.width / 2,
                       height: 150,
                       alignment: .center)
                .background(ColorCollection.black.opacity(0.75))
                .cornerRadius(20)
                .opacity(isLoading ? 1 : 0)
            }
        }
    }
}
