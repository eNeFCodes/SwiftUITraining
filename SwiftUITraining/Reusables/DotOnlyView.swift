//
//  DotOnlyView.swift
//  SwiftUITraining
//
//  Created by Neil Francis Hipona on 3/31/22.
//

import SwiftUI

struct DotOnlyView: View {

    var dotColor: Color = .orange
    var dotInactiveColor: Color = .clear
    var range: ClosedRange<Int>

    @Binding var activeIndex: Int

    var body: some View {
        VStack {
            Spacer()
            HStack(alignment: .center) {
                ForEach(range, id: \.self) { idx in
                    if activeIndex == idx {
                        activeDotIndicator(index: idx)
                    } else {
                        dotIndicator(index: idx)
                    }
                }
            }
            .padding(.bottom, 40)
        }
    }

    private func dotIndicator(index: Int) -> some View {
        Button("XXX") {
            activeIndex = index
        }
        .foregroundColor(.clear)
        .frame(width: 15, height: 15, alignment: .center)
        .overlay {
            Circle()
                .frame(width: 15, height: 15, alignment: .center)
                .foregroundColor(dotInactiveColor)
                .overlay {
                    let rect = CGRect(x: 0, y: 0, width: 15, height: 15)
                    let roundPath = Path(roundedRect: rect, cornerRadius: 7.5, style: .continuous)
                    ShapeView(path: roundPath)
                        .stroke(dotColor, lineWidth: 2)
                }
        }
    }

    private func activeDotIndicator(index: Int) -> some View {
        Button("XXX") {
            activeIndex = index
        }
        .foregroundColor(.clear)
        .frame(width: 15, height: 15, alignment: .center)
        .overlay {
            Circle()
                .frame(width: 15, height: 15, alignment: .center)
                .foregroundColor(dotColor)
                .overlay {
                    let rect = CGRect(x: 0, y: 0, width: 15, height: 15)
                    let roundPath = Path(roundedRect: rect, cornerRadius: 7.5, style: .continuous)
                    ShapeView(path: roundPath)
                        .stroke(dotColor, lineWidth: 2)
                }
        }
    }
}


struct DotOnlyView_Previews: PreviewProvider {
    @State static var activeIndex: Int = 0
    static var previews: some View {
        DotOnlyView(range: 0...3, activeIndex: $activeIndex)
    }
}
