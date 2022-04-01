//
//  Color+Ext.swift
//  SwiftUITraining
//
//  Created by Neil Francis Hipona on 3/30/22.
//

import Foundation
import SwiftUI

struct ColorCollection {
    static var white: Color = .init(hex: "FFFFFF")
    static var black: Color = .init(hex: "0D0D0D")
    static var red: Color = .init(hex: "C10016")
    static var gold: Color = .init(hex: "AC9852")
    static var lightBeige: Color = .init(hex: "F6F5EF")

    static var goldInactiveDotColor: Color = .init(hex: "726847")
    static var whiteInactiveDotColor: Color = .init(hex: "FFFFFF").opacity(0.54)
}
