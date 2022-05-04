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
            .debounce(for: .seconds(1), scheduler: DispatchQueue.global(qos: .background))
            .map { [weak self] (id, text) -> AnyPublisher<[SearchPageViewModel.Searched], Never> in
                guard let self = self else { return PassthroughSubject<[SearchPageViewModel.Searched], Never>().eraseToAnyPublisher() }
                return self.performFilter(for: text)
            }
            .switchToLatest()
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] results in
                guard let self = self else { return }
                self.searchResults = results
            })
            .store(in: &subscriptions)
    }
}

extension SearchPageViewModel {
    func triggerInputFieldOnChangeAction(id: Int, text: String) {
        if text.isEmpty {
            searchResults = []
        } else {
            textChange.send((id, text))
        }
    }

    func triggerInputFieldAction(id: Int, text: String) {
        searchedText = ""
        searchResults = []
    }

    private func performFilter(for query: String) -> AnyPublisher<[SearchPageViewModel.Searched], Never> {
        if query.isEmpty {
            return CurrentValueSubject([]).eraseToAnyPublisher()
        } else {
            let results = toSearchItems.filter({ item in
                item.title.lowercased().hasPrefix(query.lowercased())
            })
            return CurrentValueSubject(results).eraseToAnyPublisher()
        }
    }
}
