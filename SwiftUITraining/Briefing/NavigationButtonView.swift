//
//  NavigationButtonView.swift
//  SwiftUITraining
//
//  Created by Neil Francis Hipona on 3/21/22.
//

import SwiftUI

struct NavigationButtonView: View {
    @State var buttons: [NavigationButtonItem]

    var body: some View {
        HStack {
            ForEach(buttons, id: \.id) { item in
                createButton(for: item)
            }
        }
    }

    private func createButton(for btnItem: NavigationButtonItem) -> some View {
        Button {
            buttons = buttons.map { item in
                item.copy(isActive: item.id == btnItem.id)
            }
            btnItem.action()
        } label: {
            HStack {
                if btnItem.isActive {
                    btnItem.activeIcon
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: btnItem.iconSize.width, height: btnItem.iconSize.height, alignment: .center)
                        .padding(.leading, 10)

                    let font = Font.custom("FancyCutCondProB7-Bold", size: 20)
                    Text(btnItem.title)
                        .accessibilityLabel(btnItem.title)
                        .foregroundColor(btnItem.titleColor)
                        .font(font)
                        .padding(.trailing, 10)
                } else {
                    btnItem.icon
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: btnItem.iconSize.width, height: btnItem.iconSize.height, alignment: .center)
                }
            }
            .padding(10)
            .background(btnItem.isActive ? btnItem.activeBGColor : btnItem.bgColor)
            .cornerRadius(btnItem.cornerRadius)
            .overlay {
                GeometryReader { geometry in
                    let cornerRadius = abs(geometry.size.height) / 2
                    let rect = CGRect(x: 0, y: 0, width: abs(geometry.size.width), height: abs(geometry.size.height))
                    let roundedPath = Path(roundedRect: rect, cornerRadius: cornerRadius, style: .continuous)
                    ShapeView(path: roundedPath)
                        .stroke(btnItem.isActive ? btnItem.activeStrokeColor : btnItem.strokeColor, lineWidth: 1)
                }
            }
        }
        .tag(btnItem.id)
    }
}

struct BriefingNavView_Previews: PreviewProvider {

    static let buttons: [NavigationButtonItem] = [

    ]

    static var previews: some View {
        NavigationButtonView(buttons: buttons)
    }
}
