//
//  InputFieldView.swift
//  SwiftUITraining
//
//  Created by Neil Francis Hipona on 3/23/22.
//

import SwiftUI



struct InputFieldView: View {

    struct Config: Identifiable {
        let id: Int
        var text: Binding<String>
        let geometry: GeometryProxy

        let placeholder: String
        let placeholderTextColor: Color
        let textColor: Color

        let showSeparator: Bool
        let showButton: Bool
        let icon: Image?
        let action: ((_ id: Int, _ text: String) -> Void)?

        init(id: Int,
             text: Binding<String>,
             geometry: GeometryProxy,

             placeholder: String = "Search CNT",
             placeholderTextColor: Color = .gray,
             textColor: Color = .white,

             showSeparator: Bool = true,
             showButton: Bool = false,
             icon: Image? = nil,
             action: ((_ id: Int, _ text: String) -> Void)? = nil) {

            self.id = id
            self.text = text
            self.geometry = geometry

            self.placeholder = placeholder
            self.placeholderTextColor = placeholderTextColor
            self.textColor = textColor

            self.showSeparator = showSeparator
            self.showButton = showButton
            self.icon = icon
            self.action = action
        }

        func trigger() {
            action?(id, text.wrappedValue)
        }
    }

    var config: Config
    
    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 10) {
                ZStack(alignment: .leading) {
                    if config.text.wrappedValue.isEmpty {
                        Text(config.placeholder)
                            .accessibilityLabel(config.placeholder)
                            .foregroundColor(config.placeholderTextColor)
                    }
                    TextField("", text: config.text)
                        .frame(height: 56, alignment: .leading)
                        .foregroundColor(config.textColor)

                }
                .padding(.leading, 20)

                if config.showButton, let icon = config.icon {
                    Button {
                        config.trigger()
                    } label: {
                        icon
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 56, height: 56, alignment: .center)
                    }
                    .padding(.trailing, 20)
                }
            }

            if config.showSeparator {
                let p1 = CGPoint(x: 0, y: 0)
                let p2 = CGPoint(x: config.geometry.size.width - 40, y: 0)
                BorderView(coordinates: [p1, p2])
                    .stroke(Color.white, lineWidth: 1)
                    .padding(.leading, 20)
                    .padding(.trailing, 20)
            }
        }
    }
}

struct InputFieldView_Previews: PreviewProvider {
    @State static var text: String = ""
    static var previews: some View {
        GeometryReader { geometry in
            let config = InputFieldView.Config(id: 0, text: $text, geometry: geometry)
            InputFieldView(config: config)
        }
    }
}
