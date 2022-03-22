//
//  FTUEContentView.swift
//  SwiftUITraining
//
//  Created by Neil Francis Hipona on 3/18/22.
//

import SwiftUI

struct FTUEContentView: View {

    private struct ViewOffsetKey: PreferenceKey {
        typealias Value = CGFloat
        static var defaultValue = CGFloat.zero
        static func reduce(value: inout Value, nextValue: () -> Value) {
            value += nextValue()
        }
    }

    @EnvironmentObject private var appEnv: AppEnv
    @Environment(\.presentationMode) private var presentationMode
    @State private var currentIndex: Int = 0
    @State private var getStartedActive: Bool = false

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    Spacer()
                    Image("img_ftue_bottom_bg")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 230, alignment: .top)
                }

                ScrollView(.horizontal) {
                    ScrollViewReader { proxy in
                        LazyHStack {
                            ForEach(0...3, id: \.self) { index in
                                switch index {
                                case 1:
                                    let item = FTUEShowcaseView.ShowcaseItem(title: "EASILY ACCESS YOUR\nDAILY BRIEFING",
                                                                             detail: "Your Brief is curated with the\nthings you need to know today.",
                                                                             content: Image("img_ftue2"))
                                    FTUEShowcaseView(item: item)
                                        .tag(index)
                                        .frame(width: abs(geometry.size.width), alignment: .center)

                                case 2:
                                    let item = FTUEShowcaseView.ShowcaseItem(title: "CHEAT SHEET HELPS\nWITH YOUR SALES",
                                                                             detail: "You can find all the latest\nproduct and allocation stories.",
                                                                             content: Image("img_ftue3"))
                                    FTUEShowcaseView(item: item)
                                        .tag(index)
                                        .frame(width: abs(geometry.size.width), alignment: .center)

                                case 3:
                                    let item = FTUEShowcaseView.ShowcaseItem(title: "ACCESS HELPFUL\nRESOURCES ON THE GO",
                                                                             detail: "Find and download articles,\nfiles, and resources.",
                                                                             content: Image("img_ftue4"))
                                    FTUEShowcaseView(item: item)
                                        .tag(index)
                                        .frame(width: abs(geometry.size.width), alignment: .center)

                                default:
                                    FTUEIntroView()
                                        .tag(index)
                                        .frame(width: abs(geometry.size.width), alignment: .center)
                                }
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
                    .background {
                        GeometryReader { geometry in
                            Color.clear.preference(key: ViewOffsetKey.self,
                                                   value: abs(geometry.frame(in: .named("scroll")).origin.x))
                        }
                    }
                }
                .coordinateSpace(name: "scroll")
                .onPreferenceChange(ViewOffsetKey.self) { offsetX in
//                    let newIndex = Int(offsetX / UIScreen.main.bounds.width)
//                    if newIndex != currentIndex {
//                        currentIndex = newIndex
//                    }
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

                DotView(range: 0...3, action: {
                    getStartedActive = true
                }, activeIndex: $currentIndex)

                NavigationLink("", isActive: $getStartedActive) {
                    BriefingView()
                }
            }
        }
        .background(Color.black)
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}

struct FTUEView_Previews: PreviewProvider {
    static var previews: some View {
        FTUEContentView()
    }
}
