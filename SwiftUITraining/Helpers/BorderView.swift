//
//  BorderView.swift
//  SwiftUITraining
//
//  Created by Neil Francis Hipona on 3/8/22.
//

import SwiftUI

struct BorderView: Shape {
    let coordinates: [CGPoint]

    func path(in rect: CGRect) -> Path {
        var borderPath = Path()
        for (idx, coordinate) in coordinates.enumerated() {
            if idx > 0 {
                borderPath.addLine(to: coordinate)
            } else {
                borderPath.move(to: coordinate)
            }
        }
        return borderPath
    }
}
