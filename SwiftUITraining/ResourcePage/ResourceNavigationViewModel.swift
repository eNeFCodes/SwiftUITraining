//
//  ResourceNavigationViewModel.swift
//  SwiftUITraining
//
//  Created by Neil Francis Hipona on 4/8/22.
//

import Foundation
import SwiftUI

struct ResourceNavigationViewModel {
    let title: String
    let subTitle: String
    let logo: String?
    let sidePadding: CGFloat
    let btnSearchAction: () -> Void
    let btnProfileAction: () -> Void

    init(title: String,
         subTitle: String,
         logo: String? = nil,
         sidePadding: CGFloat = 32,
         btnSearchAction: @escaping () -> Void,
         btnProfileAction: @escaping () -> Void) {

        self.title = title
        self.subTitle = subTitle
        self.logo = logo
        self.sidePadding = sidePadding
        self.btnSearchAction = btnSearchAction
        self.btnProfileAction = btnProfileAction
    }
}
