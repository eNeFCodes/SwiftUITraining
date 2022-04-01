//
//  DotView.swift
//  SwiftUITraining
//
//  Created by Neil Francis Hipona on 3/21/22.
//

import SwiftUI

struct DotView: View {

    var dotColor: Color = .orange
    var dotStrokeColor: Color = .orange
    var dotInactiveColor: Color = .clear
    var dotInactiveStrokeColor: Color = .orange
    var range: ClosedRange<Int>
    var action: () -> Void
    var geometry: GeometryProxy

    @Binding var activeIndex: Int

    var body: some View {
        VStack {
            Spacer()
            HStack(alignment: .center) {
                if activeIndex == range.last {
                    Button(action: action, label: {
                        let titleStr = "GET STARTED"
                        let font = Font.custom("FancyCutCondProB7-Bold", size: 20)
                        Text(titleStr)
                            .accessibilityLabel(titleStr)
                            .font(font)
                            .foregroundColor(.white)
                            .frame(width: abs(geometry.size.width - 40), height: 56, alignment: .center)
                            .background(Color.red)
                    })
                } else {
                    ForEach(range, id: \.self) { idx in
                        if activeIndex == idx {
                            activeDotIndicator(index: idx)
                        } else {
                            dotIndicator(index: idx)
                        }
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
                        .stroke(dotInactiveStrokeColor, lineWidth: 2)
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
                        .stroke(dotStrokeColor, lineWidth: 2)
                }
        }
    }
}

struct DotView_Previews: PreviewProvider {
    @State static var activeIndex: Int = 0
    static var previews: some View {
        GeometryReader { geometry in
            DotView(range: 0...3, action: {

            }, geometry: geometry, activeIndex: $activeIndex)
        }
    }
}
