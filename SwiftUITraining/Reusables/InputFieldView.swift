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

        let placeholder: String
        let placeholderTextColor: Color
        let textColor: Color

        let showSeparator: Bool
        let separatorColor: Color
        let showButton: Bool
        let icon: Image?
        let onChangeAction: ((_ id: Int, _ text: String) -> Void)?
        let action: ((_ id: Int, _ text: String) -> Void)?

        init(id: Int,
             text: String = "",

             placeholder: String = "Search CNT",
             placeholderTextColor: Color = .gray,
             textColor: Color = .white,

             showSeparator: Bool = true,
             separatorColor: Color = .white,
             showButton: Bool = false,
             icon: Image? = nil,
             onChangeAction: ((_ id: Int, _ text: String) -> Void)? = nil,
             action: ((_ id: Int, _ text: String) -> Void)? = nil) {

            self.id = id
            self.text = text

            self.placeholder = placeholder
            self.placeholderTextColor = placeholderTextColor
            self.textColor = textColor

            self.showSeparator = showSeparator
            self.separatorColor = separatorColor
            self.showButton = showButton
            self.icon = icon

            self.onChangeAction = onChangeAction
            self.action = action
        }

        func trigger() {
            action?(id, text)
        }

        func onChange() {
            onChangeAction?(id, text)
        }
    }

    @StateObject var config: Config
    
    var body: some View {
        GeometryReader { geometry in
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
                                config.onChange()
                            }

                    }

                    if config.showButton, let icon = config.icon {
                        Button {
                            config.trigger()
                        } label: {
                            icon
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 40, height: 40, alignment: .center)
                        }
                    }
                }

                if config.showSeparator {
                    let p1 = CGPoint(x: 0, y: 0)
                    let p2 = CGPoint(x: abs(geometry.size.width), y: 0)
                    BorderView(coordinates: [p1, p2])
                        .stroke(config.separatorColor, lineWidth: 1)
                }
            }
            .frame(width: geometry.size.width, height: 51, alignment: .center)
        }
        .frame(height: 51, alignment: .center)
    }
}

struct InputFieldView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            let config = InputFieldView.Config(id: 0,
                                               text: "",
                                               showButton: true,
                                               icon: Image("ic_search_white"),
                                               action: triggerInputFieldAction)

            let config2 = InputFieldView.Config(id: 1,
                                                text: "",
                                                separatorColor: .yellow,
                                                showButton: true,
                                                icon: Image("ic_search"),
                                                action: triggerInputFieldAction)

            let config3 = InputFieldView.Config(id: 3,
                                                text: "",
                                                showSeparator: false,
                                                showButton: true,
                                                icon: Image("ic_eye_white"),
                                                action: triggerInputFieldAction)

            ForEach([config, config2, config3], id: \.id) { config in
                InputFieldView(config: config)
            }

            Spacer()
        }
        .background(Color.black)
    }

    private static func triggerInputFieldAction(id: Int, text: String) {
        print("triggered: \(id) -- \(text)")
    }
}
