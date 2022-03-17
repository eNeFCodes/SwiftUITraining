//
//  ToastView.swift
//  SwiftUITraining
//
//  Created by Neil Francis Hipona on 3/15/22.
//

import SwiftUI

class ToastModel: ObservableObject {
    @Published var title: String
    @Published var message: String
    @Published var icon: Image?
    @Published var backgroundColor: Color = .gray

    init(title: String,
         message: String,
         icon: Image? = nil) {

        self.title = title
        self.message = message
        self.icon = icon
    }
}

struct ToastView<Content: View>: View {

    @Binding var model: ToastModel
    @Binding var showingToast: Bool
    var content: () -> Content

    var body: some View {
        ZStack {
            content()

            if showingToast {
                VStack {
                    HStack(alignment: .bottom, spacing: 10) {
                        ZStack {
                            HStack {
                                VStack(alignment: .leading, spacing: 10) {
                                    Text(model.title)
                                    Text(model.message)
                                }
                                Spacer()
                            }
                            HStack {
                                Spacer()
                                VStack(alignment: .trailing, spacing: 10) {
                                    model.icon
                                }
                            }
                        }
                    }
                    .padding(.top, 40)
                    .foregroundColor(.white)
                    .padding(10)
                    .background {
                        model.backgroundColor
                    }

                    Spacer()
                }
                .ignoresSafeArea()
            }
        }
    }
}

//extension VerticalAlignment {
//    private enum MidContentAlignment: AlignmentID {
//        static func defaultValue(in context: ViewDimensions) -> CGFloat {
//            return 0
//        }
//    }
//    static let midContentAlignment = VerticalAlignment(MidContentAlignment.self)
//}
