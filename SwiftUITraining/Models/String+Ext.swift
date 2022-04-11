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

    func constrainedSize(in canvas: CGSize, minHeight: CGFloat, attributes: [NSAttributedString.Key: Any]) -> CGSize {
        let rectSize = self.boundingRect(with: canvas,
                                     options: [.usesLineFragmentOrigin, .usesFontLeading],
                                     attributes: attributes, context: nil)
        let rectHeight = rectSize.height > minHeight ? rectSize.height : minHeight
        return .init(width: rectSize.width, height: rectHeight)
    }

    func constrainedSize(with canvas: CGSize, minHeight: CGFloat, font: UIFont) -> CGFloat {
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        let rectSize = constrainedSize(in: canvas, minHeight: minHeight, attributes: attributes)
        let constrainedHeight = rectSize.height > minHeight ? rectSize.height : minHeight
        return constrainedHeight
    }

    func constrainedSize(with canvas: CGSize, minHeight: CGFloat, attributes: [NSAttributedString.Key: Any]) -> CGFloat {
        let rect = self.boundingRect(with: canvas, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: attributes, context: nil)
        let constrainedHeight = rect.height > minHeight ? rect.height : minHeight
        return constrainedHeight
    }
}
