//
//  FTUEContentView.swift
//  SwiftUITraining
//
//  Created by Neil Francis Hipona on 3/18/22.
//

import SwiftUI

struct FTUEContentView: View {

    @EnvironmentObject private var appEnv: AppEnv
    @Environment(\.presentationMode) private var presentationMode
    @State private var currentIndex: Int = 0

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    Spacer()
                    Image("img_bg_login")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 230, alignment: .top)
                }

                ScrollView(.horizontal) {
                    ScrollViewReader { proxy in
                        LazyHStack {
                            ForEach(0...3, id: \.self) { index in
                                FTUEIntroView()
                                    .tag(index)
                                    .frame(width: abs(geometry.size.width), alignment: .center)
                            }
                        }
                        .padding(.top, 20)
                        .padding(.bottom, 100)
                        .onChange(of: currentIndex) { newValue in
                            withAnimation {
                                proxy.scrollTo(newValue, anchor: .center)
                            }
                        }
                    }
                }

                VStack {
                    Button("X") {
                        appEnv.isLoggedIn = false
                        presentationMode.wrappedValue.dismiss()
                    }
                    .frame(width: 50, height: 50)
                    .foregroundColor(.white)
                    Spacer()
                }
                .padding(20)
                .padding(.top, 20)
                .frame(width: abs(geometry.size.width), alignment: .trailing)

                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        ForEach(0...3, id: \.self) { idx in
                            if currentIndex == idx {
                                activeDotIndicator(index: idx)
                            } else {
                                dotIndicator(index: idx)
                            }
                        }
                        Spacer()
                    }
                    .padding(20)
                    .frame(width: abs(geometry.size.width))
                    .padding(.bottom, 40)
                }
            }
        }
        .background(Color.black)
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }

    private func dotIndicator(index: Int) -> some View {
        Button("XXX") {
            currentIndex = index
        }
        .foregroundColor(.clear)
        .frame(width: 15, height: 15, alignment: .center)
        .overlay {
            Circle()
                .frame(width: 15, height: 15, alignment: .center)
                .overlay {
                    let rect = CGRect(x: 0, y: 0, width: 15, height: 15)
                    let roundPath = Path(roundedRect: rect, cornerRadius: 7.5, style: .continuous)
                    ShapeView(path: roundPath)
                        .stroke(Color.orange, lineWidth: 2)
                }
        }
    }

    private func activeDotIndicator(index: Int) -> some View {
        Button("XXX") {
            currentIndex = index
        }
        .foregroundColor(.clear)
        .frame(width: 15, height: 15, alignment: .center)
        .overlay {
            Circle()
                .frame(width: 15, height: 15, alignment: .center)
                .foregroundColor(.orange)
                .overlay {
                    let rect = CGRect(x: 0, y: 0, width: 15, height: 15)
                    let roundPath = Path(roundedRect: rect, cornerRadius: 7.5, style: .continuous)
                    ShapeView(path: roundPath)
                        .stroke(Color.orange, lineWidth: 2)
                }
        }
    }
}

struct FTUEView_Previews: PreviewProvider {
    static var previews: some View {
        FTUEContentView()
    }
}
