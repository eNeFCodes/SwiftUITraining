//
//  ResourceReportViewModel.swift
//  SwiftUITraining
//
//  Created by Neil Francis Hipona on 4/12/22.
//

import Foundation

struct ResourceReportViewModel {

    let id: Int
    let shortTitle: String
    let longTitle: String
    let message: String
    let attachment: String?

    init(id: Int, shortTitle: String, longTitle: String, message: String, attachment: String? = nil) {
        self.id = id
        self.shortTitle = shortTitle
        self.longTitle = longTitle
        self.message = message
        self.attachment = attachment
    }
}
