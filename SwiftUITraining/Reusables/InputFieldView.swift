//
//  InputFieldView.swift
//  SwiftUITraining
//
//  Created by Neil Francis Hipona on 3/23/22.
//

import SwiftUI



struct InputFieldView: View {

    class Config: Identifiable, ObservableObject {
        let id: Int
        @Published var text: String
        let geometry: GeometryProxy

        let placeholder: String
        let placeholderTextColor: Color
        let textColor: Color

        let showSeparator: Bool
        let showButton: Bool
        let icon: Image?
        let action: ((_ id: Int, _ text: String) -> Void)?

        init(id: Int,
             text: String = "",
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
            action?(id, text)
        }
    }

    @StateObject var config: Config
    
    var body: some View {
        VStack(spacing: 10) {
            HStack(alignment: .center, spacing: 10) {
                ZStack(alignment: .leading) {
                    if config.text.isEmpty {
                        Text(config.placeholder)
                            .accessibilityLabel(config.placeholder)
                            .foregroundColor(config.placeholderTextColor)
                    }
                    TextField("", text: $config.text)
                        .frame(height: 40, alignment: .leading)
                        .foregroundColor(config.textColor)
                        .onChange(of: config.text) { newValue in
                            config.trigger()
                        }

                }
                .padding(.leading, 20)

                if config.showButton, let icon = config.icon {
                    Button {
                        config.trigger()
                    } label: {
                        icon
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40, alignment: .center)
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
        .frame(height: 51, alignment: .center)
    }
}

struct InputFieldView_Previews: PreviewProvider {
    @State static var text: String = ""
    static var previews: some View {
        GeometryReader { geometry in
            let config = InputFieldView.Config(id: 0, text: text, geometry: geometry)
            InputFieldView(config: config)
        }
    }
}
