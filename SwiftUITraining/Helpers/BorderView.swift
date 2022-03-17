//
//  BorderView.swift
//  SwiftUITraining
//
//  Created by Neil Francis Hipona on 3/8/22.
//

import SwiftUI

struct BorderView: Shape {
    var coordinates: [CGPoint]

    func path(in rect: CGRect) -> Path {
        let borderPath = UIBezierPath()
        for (idx, coordinate) in coordinates.enumerated() {
            if idx > 0 {
                borderPath.addLine(to: coordinate)
            } else {
                borderPath.move(to: coordinate)
            }
        }
        return Path(borderPath.cgPath)
    }
}
