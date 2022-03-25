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
        let title: String
        let subTitle: String
        let imageName: String
        let date: String

        init(id: Int,
             title: String,
             subTitle: String = "",
             imageName: String = "",
             date: String = "") {

            self.id = id
            self.title = title
            self.subTitle = subTitle
            self.imageName = imageName
            self.date = date
        }
    }

    @EnvironmentObject private var appEnv: AppEnv
    @Environment(\.presentationMode) private var presentationMode
    @State private var popularSearches: [Searched] = SearchMockData.popularSearches

    @State private var searchResults: [Searched] = []

    @State private var searchedText: String = "asdfadfaf"
    @State private var selectedItem: Searched?

    private var toSearchItems: [Searched] = SearchMockData.toSearchItems

    var body: some View {
        let shouldSwitchColor = !searchedText.isEmpty && !searchResults.isEmpty
        let bgColorAll: Color = shouldSwitchColor ? .white : .black
        GeometryReader { geometry in
            ZStack {
                VStack {
                    let hSize = CGSize(width: geometry.size.width * 0.75, height: 120)
                    HStack {
                        let titleFont = Font.custom("FancyCutCondProB7-Bold", size: 30)
                        let titleStr = "SEARCH"
                        let fgColor: Color = shouldSwitchColor ? .white : .black
                        let bgColor: Color = shouldSwitchColor ? .black : .white

                        Text(titleStr)
                            .accessibilityLabel(titleStr)
                            .font(titleFont)
                            .foregroundColor(fgColor)
                            .padding(20)
                            .padding(.top, 20)
                            .frame(width: abs(hSize.width), height: hSize.height, alignment: .leading)
                            .background(bgColor)
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
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            let closeIcon = shouldSwitchColor ? Image("ic_close") : Image("ic_close_white")
                            closeIcon
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50, alignment: .center)
                                .padding(20)
                        }
                    }
                    .padding(.top, 20)
                    Spacer()
                }
            }
            .frame(width: abs(geometry.size.width), alignment: .center)

            VStack {
                InputFieldView(text: $searchedText, config: makeSearchFieldConfig())
                    .padding(20)

                ZStack {
                    if !searchedText.isEmpty && searchResults.isEmpty {
                        emptyResultView(geometry: geometry)
                    } else {
                        resultsView(geometry: geometry)
                    }
                }
            }
            .padding(.top, 150)
        }
        .background(bgColorAll)
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }

    private func makeSearchFieldConfig() -> InputFieldView.Config {
        if !searchResults.isEmpty {
            return InputFieldView.Config(id: 0,
                                         titleColor: .black,
                                         textColor: .black,
                                         separatorColor: .black,
                                         showButton: true,
                                         icon: Image("ic_search_white"),
                                         activeIcon: Image("ic_close"),
                                         onChangeAction: triggerInputFieldOnChangeAction,
                                         action: triggerInputFieldAction)
        } else {
            return InputFieldView.Config(id: 0,
                                         titleColor: .white,
                                         textColor: .white,
                                         separatorColor: .white,
                                         showButton: true,
                                         icon: Image("ic_search_white"),
                                         activeIcon: Image("ic_close_white"),
                                         onChangeAction: triggerInputFieldOnChangeAction,
                                         action: triggerInputFieldAction)
        }
    }

    private func emptyResultView(geometry: GeometryProxy) -> some View {
        VStack(spacing: 10) {
            Spacer()

            let noResultFont = Font.custom("FancyCutCondProB7-Bold", size: 15)
            let noResult = "NO RESULTS FOUND"
            Text(noResult)
                .accessibilityLabel(noResult)
                .font(noResultFont)
                .foregroundColor(.yellow)
                .multilineTextAlignment(.center)

            let noResultMsgFont = Font.custom("BrilliantCutProB7-Regular", size: 20)
            let noResultMsg = "Please try searching for\nsomething else."
            Text(noResultMsg)
                .accessibilityLabel(noResultMsg)
                .font(noResultMsgFont)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)

            Spacer()
        }
        .frame(width: abs(geometry.size.width), alignment: .center)
    }

    private func resultsView(geometry: GeometryProxy) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            let searchedTitleFont = Font.custom("FancyCutCondProB7-Bold", size: 20)
            let searchedTitle = !searchResults.isEmpty ? "\(searchResults.count) RESULTS" : "POPULAR SEARCHES"
            Text(searchedTitle)
                .accessibilityLabel(searchedTitle)
                .font(searchedTitleFont)
                .foregroundColor(.yellow)
                .padding(20)

            ScrollView(.vertical) {
                if !searchResults.isEmpty {
                    ForEach(searchResults) { searched in
                        createResultItemView(for: searched, geometry: geometry)
                    }
                } else {
                    ForEach(popularSearches) { searched in
                        createTappableField(for: searched, geometry: geometry)
                    }
                    .foregroundColor(.white)
                }
            }
        }
        .frame(width: abs(geometry.size.width), alignment: .leading)
    }

    private func createResultItemView(for item: Searched, geometry: GeometryProxy) -> some View {
        SearchResultItemView(item: item, action: resultActionHandler)
            .frame(width: geometry.size.width, height: SearchResultItemView.calculatedHeight(geometry: geometry))
    }

    private func resultActionHandler(item: Searched) {
        print("resultActionHandler: ", item)
    }

    private func createTappableField(for item: Searched, geometry: GeometryProxy) -> some View {
        Button {
            searchedItemTapped(item: item)
        } label: {
            Text(item.title)
                .accessibilityLabel(item.title)
                .tag(item.id)
                .frame(width: abs(geometry.size.width), height: 40, alignment: .leading)
                .padding(.leading, 20)
                .padding(.trailing, 20)
        }
    }

    private func triggerInputFieldOnChangeAction(id: Int, text: String) {
        print("triggered: \(id) -- \(text)")
        if text.isEmpty {
            searchResults = []
        } else {
            searchResults = toSearchItems.filter({ item in
                item.title.lowercased().hasPrefix(text.lowercased())
            })
        }
    }

    private func triggerInputFieldAction(id: Int, text: String) {
        searchedText = ""
        searchResults = []
    }

    private func searchedItemTapped(item: Searched) {
        print("searchedItemTapped: \(item.id) -- \(item.title)")
    }
}

struct SearchPage_Previews: PreviewProvider {
    static var previews: some View {
        SearchPageView()
    }
}
