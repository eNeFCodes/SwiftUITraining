//
//  SearchPageViewModel.swift
//  SwiftUITraining
//
//  Created by Neil Francis Hipona on 4/25/22.
//

import SwiftUI
import Combine

class SearchPageViewModel: ObservableObject {
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

    @Published var popularSearches: [Searched] = SearchMockData.popularSearches
    @Published var searchResults: [Searched] = []
    @Published var searchedText: String = "asdfadfaf"
    @Published var selectedItem: Searched?

    var toSearchItems: [SearchPageViewModel.Searched] = SearchMockData.toSearchItems
}

extension SearchPageViewModel {
    func triggerInputFieldOnChangeAction(id: Int, text: String) {
        print("triggered: \(id) -- \(text)")
        if text.isEmpty {
            searchResults = []
        } else {
            searchResults = toSearchItems.filter({ item in
                item.title.lowercased().hasPrefix(text.lowercased())
            })
        }
    }

    func triggerInputFieldAction(id: Int, text: String) {
        searchedText = ""
        searchResults = []
    }
}
