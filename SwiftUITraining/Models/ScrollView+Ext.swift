//
//  ScrollView+Ext.swift
//  SwiftUITraining
//
//  Created by Neil Francis Hipona on 3/30/22.
//

import Foundation
import SwiftUI

struct ScrollViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}
