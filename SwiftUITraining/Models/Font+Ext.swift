//
//  Font+Ext.swift
//  SwiftUITraining
//
//  Created by Neil Francis Hipona on 3/28/22.
//

import Foundation
import SwiftUI
import UIKit

extension UIFont {

    func toFont() -> Font {
        let castedFont = Font(self as CTFont)
        return castedFont
    }
}
