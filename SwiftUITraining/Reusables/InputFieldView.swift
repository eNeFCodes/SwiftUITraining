//
//  InputFieldView.swift
//  SwiftUITraining
//
//  Created by Neil Francis Hipona on 3/23/22.
//

import SwiftUI



struct InputFieldView: View {

    class Config: Identifiable {
        let id: Int
        let title: String
        let titleColor: Color
        let placeholder: String
        let placeholderTextColor: Color
        let textColor: Color

        let showSeparator: Bool
        let separatorColor: Color
        let showButton: Bool
        let icon: Image?
        var activeIcon: Image?
        let onChangeAction: ((_ id: Int, _ text: String) -> Void)?
        let action: ((_ id: Int, _ text: String) -> Void)?

        init(id: Int,
             title: String = "Search CNT",
             titleColor: Color = .white,
             placeholder: String = "Search CNT",
             placeholderTextColor: Color = Color("c_gray"),
             textColor: Color = Color("c_green"),

             showSeparator: Bool = true,
             separatorColor: Color = .white,
             showButton: Bool = false,
             icon: Image? = nil,
             activeIcon: Image? = nil,
             onChangeAction: ((_ id: Int, _ text: String) -> Void)? = nil,
             action: ((_ id: Int, _ text: String) -> Void)? = nil) {

            self.id = id
            self.title = title
            self.titleColor = titleColor
            self.placeholder = placeholder
            self.placeholderTextColor = placeholderTextColor
            self.textColor = textColor

            self.showSeparator = showSeparator
            self.separatorColor = separatorColor
            self.showButton = showButton
            self.icon = icon
            self.activeIcon = activeIcon

            self.onChangeAction = onChangeAction
            self.action = action
        }

        func trigger(text: String) {
            action?(id, text)
        }

        func onChange(text: String) {
            onChangeAction?(id, text)
        }
    }

    @Binding var text: String
    var config: Config
    @State var showTitle: Bool = false
    
    var body: some View {
        let maxFieldHeight: CGFloat = text.isEmpty ? 49 : 77
        GeometryReader { geometry in
            VStack(spacing: 8) {
                if showTitle {
                    let titleFont = Font.custom("BrilliantCutProB7-Regular", size: 15)
                    Text(config.title)
                        .accessibilityLabel(config.title)
                        .foregroundColor(config.titleColor)
                        .font(titleFont)
                        .frame(width: geometry.size.width, height: 20, alignment: .leading)
                        .transition(.move(edge: .bottom))
                }

                HStack(alignment: .center, spacing: 10) {
                    ZStack(alignment: .leading) {
                        if text.isEmpty {
                            Text(config.placeholder)
                                .accessibilityLabel(config.placeholder)
                                .foregroundColor(config.placeholderTextColor)
                        }
                        TextField("", text: $text)
                            .frame(height: 40, alignment: .leading)
                            .foregroundColor(config.textColor)
                            .onChange(of: text) { newValue in
                                config.onChange(text: newValue)
                            }
                    }

                    if config.showButton, let icon = config.icon, let activeIcon = config.activeIcon {
                        Button {
                            config.trigger(text: text)
                        } label: {
                            if !text.isEmpty {
                                activeIcon
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 40, height: 40, alignment: .center)
                            } else {
                                icon
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 40, height: 40, alignment: .center)
                            }
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
            .frame(width: geometry.size.width, height: maxFieldHeight, alignment: .center)
            .onChange(of: text) { newValue in
                withAnimation {
                    showTitle = !newValue.isEmpty
                }
            }
        }
        .frame(height: maxFieldHeight, alignment: .center)
    }
}

struct InputFieldView_Previews: PreviewProvider {
    @State static var text: String = ""
    static var previews: some View {
        VStack {
            let config = InputFieldView.Config(id: 0,
                                               showButton: true,
                                               icon: Image("ic_search_white"),
                                               action: triggerInputFieldAction)

            let config2 = InputFieldView.Config(id: 1,
                                                separatorColor: .yellow,
                                                showButton: true,
                                                icon: Image("ic_search"),
                                                action: triggerInputFieldAction)

            let config3 = InputFieldView.Config(id: 3,
                                                showSeparator: false,
                                                showButton: true,
                                                icon: Image("ic_eye_white"),
                                                action: triggerInputFieldAction)

            ForEach([config, config2, config3], id: \.id) { config in
                InputFieldView(text: $text, config: config)
            }

            Spacer()
        }
        .background(ColorCollection.black)
    }

    private static func triggerInputFieldAction(id: Int, text: String) {
        print("triggered: \(id) -- \(text)")
    }
}
