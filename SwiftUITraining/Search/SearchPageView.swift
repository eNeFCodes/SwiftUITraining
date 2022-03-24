//
//  SearchPageView.swift
//  SwiftUITraining
//
//  Created by Neil Francis Hipona on 3/23/22.
//

import SwiftUI

struct SearchPageView: View {

    struct Searched: Identifiable, Hashable {
        let id: Int
        let text: String
    }

    @EnvironmentObject private var appEnv: AppEnv
    @State private var popularSearches: [Searched] = [
        Searched(id: 0, text:"Just Un Clou"),
        Searched(id: 1, text:"Stockholm store renovation"),
        Searched(id: 2, text:"Love bracelet")
    ]

    @State private var searchResults: [Searched] = []

    @State private var searchedText: String = ""
    @State private var selectedItem: Searched?

    private var toSearchItems: [Searched] = [
        Searched(id: 0, text:"Just Un Clou"),
        Searched(id: 1, text:"Stockholm store renovation"),
        Searched(id: 2, text:"Love bracelet"),
        Searched(id: 3, text:"Google"),
        Searched(id: 4, text:"Facebook"),
        Searched(id: 5, text:"Facebook Ads")
    ]

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    let hSize = CGSize(width: geometry.size.width * 0.75, height: 120)
                    HStack {
                        let titleFont = Font.custom("FancyCutCondProB7-Bold", size: 30)
                        let titleStr = "SEARCH"
                        Text(titleStr)
                            .accessibilityLabel(titleStr)
                            .font(titleFont)
                            .foregroundColor(.black)
                            .padding(20)
                            .padding(.top, 20)
                            .frame(width: abs(hSize.width), height: hSize.height, alignment: .leading)
                            .background(Color.white)
                            .mask {
                                let curve: CGFloat = 20
                                let p1 = CGPoint(x: 0, y: 0)
                                let p2 = CGPoint(x: hSize.width, y: 0)
                                let p3 = CGPoint(x: hSize.width, y: hSize.height - curve)
                                let p4 = CGPoint(x: hSize.width - curve, y: hSize.height)
                                let p5 = CGPoint(x: 0, y: hSize.height)
                                BorderView(coordinates: [p1, p2, p3, p4, p5], shouldClosePath: true)
                            }
                    }
                    .frame(height: hSize.height, alignment: .leading)
                    Spacer()
                }
                .ignoresSafeArea()
                .frame(width: abs(geometry.size.width), alignment: .leading)

                VStack {
                    HStack {
                        Spacer()
                        Button {
                            appEnv.isLoggedIn = false
                            appEnv.loginMode = .default
                        } label: {
                            Image("ic_close_white")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50, alignment: .center)
                                .padding(20)
                        }
                    }
                    Spacer()
                }
            }
            .frame(width: abs(geometry.size.width), alignment: .center)

            VStack {
                let config = InputFieldView.Config(id: 0,
                                                   text: "",
                                                   showButton: true,
                                                   icon: Image("ic_search_white"),
                                                   onChangeAction: triggerInputFieldAction,
                                                   action: triggerInputFieldAction)
                InputFieldView(config: config)
                    .padding(20)

                ZStack {
                    VStack(alignment: .leading, spacing: 10) {
                        let searchedTitleFont = Font.custom("FancyCutCondProB7-Bold", size: 20)
                        let searchedTitle = !searchResults.isEmpty ? "SEARCHED RESULTS" : "POPULAR SEARCHES"
                        Text(searchedTitle)
                            .accessibilityLabel(searchedTitle)
                            .font(searchedTitleFont)
                            .foregroundColor(.yellow)
                            .padding(20)

                        ScrollView(.vertical) {
                            if !searchResults.isEmpty {
                                ForEach(searchResults) { searched in
                                    createTappableField(for: searched, geometry: geometry)
                                }
                            } else {
                                ForEach(popularSearches) { searched in
                                    createTappableField(for: searched, geometry: geometry)
                                }
                            }
                        }
                        .foregroundColor(.white)
                    }
                    .frame(width: abs(geometry.size.width), alignment: .leading)
                }
            }
            .padding(.top, 150)
        }
        .background(Color.black)
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }

    private func createTappableField(for item: Searched, geometry: GeometryProxy) -> some View {
        Button {
            searchedItemTapped(item: item)
        } label: {
            Text(item.text)
                .accessibilityLabel(item.text)
                .tag(item.id)
                .frame(width: abs(geometry.size.width), height: 40, alignment: .leading)
                .padding(.leading, 20)
                .padding(.trailing, 20)
        }
    }

    private func triggerInputFieldAction(id: Int, text: String) {
        print("triggered: \(id) -- \(text)")
        searchedText = text

        if text.isEmpty {
            searchResults = []
        } else {
            searchResults = toSearchItems.filter({ item in
                item.text.lowercased().hasPrefix(text.lowercased())
            })
        }
    }

    private func searchedItemTapped(item: Searched) {
        print("searchedItemTapped: \(item.id) -- \(item.text)")
    }
}

struct SearchPage_Previews: PreviewProvider {
    static var previews: some View {
        SearchPageView()
    }
}
