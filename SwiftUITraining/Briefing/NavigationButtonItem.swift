//
//  NavigationButtonItem.swift
//  SwiftUITraining
//
//  Created by Neil Francis Hipona on 3/22/22.
//

import Foundation
import SwiftUI

struct NavigationButtonItem {
    let id: Int
    let icon: Image
    let activeIcon: Image
    let title: String
    let titleColor: Color
    let bgColor: Color
    let activeBGColor: Color
    let strokeColor: Color
    let activeStrokeColor: Color
    let iconSize: CGSize
    let cornerRadius: CGFloat
    let isActive: Bool
    let action: () -> Void

    init(id: Int,
         icon: Image,
         activeIcon: Image,
         title: String,
         titleColor: Color = .black,
         bgColor: Color = .black,
         activeBGColor: Color = .white,
         strokeColor: Color = .white,
         activeStrokeColor: Color = .black,
         iconSize: CGSize = CGSize(width: 40, height: 40),
         cornerRadius: CGFloat = 30,
         isActive: Bool = false,
         action: @escaping () -> Void) {

        self.id = id
        self.icon = icon
        self.activeIcon = activeIcon
        self.title = title
        self.titleColor = titleColor
        self.bgColor = bgColor
        self.activeBGColor = activeBGColor
        self.strokeColor = strokeColor
        self.activeStrokeColor = activeStrokeColor
        self.iconSize = iconSize
        self.cornerRadius = cornerRadius
        self.isActive = isActive
        self.action = action
    }

    func copy(isActive: Bool) -> NavigationButtonItem {
        .init(id: id,
              icon: icon,
              activeIcon: activeIcon,
              title: title,
              titleColor: titleColor,
              bgColor: bgColor,
              activeBGColor: activeBGColor,
              strokeColor: strokeColor,
              activeStrokeColor: activeStrokeColor,
              iconSize: iconSize,
              cornerRadius: cornerRadius,
              isActive: isActive,
              action: action)
    }
}
