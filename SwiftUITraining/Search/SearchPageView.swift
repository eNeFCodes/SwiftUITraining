//
//  SearchPageView.swift
//  SwiftUITraining
//
//  Created by Neil Francis Hipona on 3/23/22.
//

import SwiftUI

struct SearchPageView: View {

    @EnvironmentObject private var appEnv: AppEnv
    @Environment(\.presentationMode) private var presentationMode

    @StateObject private var model: SearchPageViewModel = .init()

    var body: some View {
        let shouldSwitchColor = !model.searchedText.isEmpty && !model.searchResults.isEmpty
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
                InputFieldView(text: $model.searchedText, config: makeSearchFieldConfig(), showTitle: !model.searchedText.isEmpty)
                    .padding(20)

                ZStack {
                    if !model.searchedText.isEmpty && model.searchResults.isEmpty {
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
        if !model.searchResults.isEmpty {
            return InputFieldView.Config(id: 0,
                                         titleColor: .black,
                                         textColor: .black,
                                         separatorColor: .black,
                                         showButton: true,
                                         icon: Image("ic_search_white"),
                                         activeIcon: Image("ic_close"),
                                         onChangeAction: model.triggerInputFieldOnChangeAction,
                                         action: model.triggerInputFieldAction)
        } else {
            return InputFieldView.Config(id: 0,
                                         titleColor: .white,
                                         textColor: .white,
                                         separatorColor: .white,
                                         showButton: true,
                                         icon: Image("ic_search_white"),
                                         activeIcon: Image("ic_close_white"),
                                         onChangeAction: model.triggerInputFieldOnChangeAction,
                                         action: model.triggerInputFieldAction)
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
            let searchedTitle = !model.searchResults.isEmpty ? "\(model.searchResults.count) RESULTS" : "POPULAR SEARCHES"
            Text(searchedTitle)
                .accessibilityLabel(searchedTitle)
                .font(searchedTitleFont)
                .foregroundColor(.yellow)
                .padding(20)

            ScrollView(.vertical) {
                LazyVStack {
                    if !model.searchResults.isEmpty {
                        ForEach(model.searchResults) { searched in
                            createResultItemView(for: searched, geometry: geometry)
                        }
                    } else {
                        ForEach(model.popularSearches) { searched in
                            createTappableField(for: searched, geometry: geometry)
                        }
                        .foregroundColor(.white)
                    }
                }
            }
        }
        .frame(width: abs(geometry.size.width), alignment: .leading)
    }

    private func createResultItemView(for item: SearchPageViewModel.Searched, geometry: GeometryProxy) -> some View {
        SearchResultItemView(geometry: geometry, item: item, action: resultActionHandler)
            .padding(.top, 20)
            .padding(.bottom, 20)
    }

    private func resultActionHandler(item: SearchPageViewModel.Searched) {
        print("resultActionHandler: ", item)
    }

    private func createTappableField(for item: SearchPageViewModel.Searched, geometry: GeometryProxy) -> some View {
        Button {
            searchedItemTapped(item: item)
        } label: {
            Text(item.title)
                .accessibilityLabel(item.title)
                .tag(item.id)
                .frame(width: abs(geometry.size.width), height: 40, alignment: .leading)
        }
        .padding(.leading, 20)
        .padding(.trailing, 20)
        .frame(width: abs(geometry.size.width), height: 40, alignment: .leading)
    }

    private func searchedItemTapped(item: SearchPageViewModel.Searched) {
        print("searchedItemTapped: \(item.id) -- \(item.title)")
    }
}

struct SearchPage_Previews: PreviewProvider {
    static var previews: some View {
        SearchPageView()
    }
}
