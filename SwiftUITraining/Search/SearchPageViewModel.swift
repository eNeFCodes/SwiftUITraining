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

    private var subscriptions = Set<AnyCancellable>()
    private var textChange = PassthroughSubject<(id: Int, text: String), Never>()

    init() {
        textChange
            .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
            .sink(receiveValue: { [weak self] (id, text) in
                guard let self = self else { return }
                self.performFilter(id: id, text: text)
            })
            .store(in: &subscriptions)
    }
}

extension SearchPageViewModel {
    func triggerInputFieldOnChangeAction(id: Int, text: String) {
        if text.isEmpty {
            searchResults = []
        }
        textChange.send((id, text))
    }

    func triggerInputFieldAction(id: Int, text: String) {
        searchedText = ""
        searchResults = []
    }

    private func performFilter(id: Int, text: String) {
        if text.isEmpty {
            searchResults = []
        } else {
            searchResults = toSearchItems.filter({ item in
                item.title.lowercased().hasPrefix(text.lowercased())
            })
        }
    }
}
