//
//  ResourceLandingPageModel.swift
//  SwiftUITraining
//
//  Created by Neil Francis Hipona on 4/12/22.
//

import Foundation

class ResourceLandingPageModel: ObservableObject {

    let titleModel: ResourceLandingTitleViewModel
    let tagsModel: TagViewModel
    let reportsModel: [ResourceReportViewModel]

    init(titleModel: ResourceLandingTitleViewModel, tagsModel: TagViewModel, reportsModel: [ResourceReportViewModel] = []) {
        self.titleModel = titleModel
        self.tagsModel = tagsModel
        self.reportsModel = reportsModel
    }
}
