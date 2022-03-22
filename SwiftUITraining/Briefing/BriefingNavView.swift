//
//  BriefingNavView.swift
//  SwiftUITraining
//
//  Created by Neil Francis Hipona on 3/21/22.
//

import SwiftUI

struct BriefingNavView: View {

    struct ButtonItem {
        let id: Int
        let icon: Image
        let title: String?
        let titleColor: Color?
        let bgColor: Color
        let strokeColor: Color
        let size: CGSize
        let cornerRadius: CGFloat

        let action: () -> Void

        init(id: Int,
             icon: Image,
             title: String? = nil,
             titleColor: Color? = nil,
             bgColor: Color,
             strokeColor: Color,
             size: CGSize = CGSize(width: 40, height: 40),
             cornerRadius: CGFloat = 30,
             action: @escaping () -> Void) {

            self.id = id
            self.icon = icon
            self.title = title
            self.titleColor = titleColor
            self.bgColor = bgColor
            self.strokeColor = strokeColor
            self.size = size
            self.cornerRadius = cornerRadius

            self.action = action
        }
    }

    let buttons: [ButtonItem]

    var body: some View {
        HStack {
            ForEach(buttons, id: \.id) { item in
                createButton(for: item)
            }
        }
    }

    private func createButton(for btnItem: ButtonItem) -> some View {
        Button {
            btnItem.action()
        } label: {
            HStack {
                if let title = btnItem.title {
                    btnItem.icon
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: btnItem.size.width, height: btnItem.size.height, alignment: .center)
                        .padding(.leading, 20)

                    let font = Font.custom("FancyCutCondProB7-Bold", size: 20)
                    Text(title)
                        .accessibilityLabel(title)
                        .foregroundColor(btnItem.titleColor)
                        .font(font)
                        .padding(.trailing, 20)
                } else {
                    btnItem.icon
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: btnItem.size.width, height: btnItem.size.height, alignment: .center)
                }
            }
            .padding(10)
            .background(btnItem.bgColor)
            .cornerRadius(btnItem.cornerRadius)
            .overlay {
                GeometryReader { geometry in
                    let cornerRadius = abs(geometry.size.height) / 2
                    let rect = CGRect(x: 0, y: 0, width: abs(geometry.size.width), height: abs(geometry.size.height))
                    let roundedPath = Path(roundedRect: rect, cornerRadius: cornerRadius, style: .continuous)
                    ShapeView(path: roundedPath)
                        .stroke(btnItem.strokeColor, lineWidth: 1)
                }
            }
        }
        .tag(btnItem.id)
    }
}

struct BriefingNavView_Previews: PreviewProvider {

    static let buttons: [BriefingNavView.ButtonItem] = [

    ]

    static var previews: some View {
        BriefingNavView(buttons: buttons)
    }
}
