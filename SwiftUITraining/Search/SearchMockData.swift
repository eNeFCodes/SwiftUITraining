//
//  SearchMockData.swift
//  SwiftUITraining
//
//  Created by Neil Francis Hipona on 3/25/22.
//

import Foundation

struct SearchMockData {
    typealias Searched = SearchPageViewModel.Searched

    static let popularSearches: [Searched] = [
        Searched(id: 0, title: "Just Un Clou"),
        Searched(id: 1, title: "Stockholm store renovation"),
        Searched(id: 2, title: "Love bracelet")
    ]

    static let toSearchItems: [Searched] = [
        Searched(id: 0,
                 title: "PANTHERE",
                 subTitle: "JUSTE sedfsa Vehicula Etiam Egestas lorem ipsum",
                 imageName: "img_result1",
                 date: "May 1, 2020"),
        Searched(id: 1,
                 title: "Love bracelet",
                 subTitle: "JUSTE sedfsa Vehicula Etiam Egestas lorem ipsum",
                 imageName: "img_result2",
                 date: "May 1, 2021"),
        Searched(id: 2,
                 title: "Google",
                 subTitle: "JUSTE sedfsa Vehicula Etiam Egestas lorem ipsum",
                 imageName: "img_result3",
                 date: "Mar 25, 2022"),
        Searched(id: 3,
                 title: "Facebook",
                 subTitle: "JUSTE sedfsa Vehicula Etiam Egestas lorem ipsum",
                 imageName: "img_result1",
                 date: "April 1, 2019"),
        Searched(id: 4,
                 title: "Facebook Ads",
                 subTitle: "JUSTE sedfsa Vehicula Etiam Egestas lorem ipsum",
                 imageName: "img_result2",
                 date: "May 1, 2021"),
        Searched(id: 5,
                 title: "Facebook Games",
                 subTitle: "JUSTE sedfsa Vehicula Etiam Egestas lorem ipsum",
                 imageName: "img_result3",
                 date: "Mar 25, 2022"),
    ]
}
