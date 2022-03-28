//
//  String+Ext.swift
//  SwiftUITraining
//
//  Created by Neil Francis Hipona on 3/28/22.
//

import Foundation
import SwiftUI
import UIKit

extension String {

    func constrainedSize(with canvas: CGSize, minHeight: CGFloat, attributes: [NSAttributedString.Key: Any]) -> CGFloat {
        let rect = self.boundingRect(with: canvas, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: attributes, context: nil)
        let constrainedHeight = rect.height > minHeight ? rect.height : minHeight
        return constrainedHeight
    }
}
