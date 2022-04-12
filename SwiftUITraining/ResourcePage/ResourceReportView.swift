//
//  ResourceReportView.swift
//  SwiftUITraining
//
//  Created by Neil Francis Hipona on 4/12/22.
//

import SwiftUI

struct ResourceReportView: View {
    let geometry: GeometryProxy
    let model: ResourceReportViewModel

    var body: some View {
        HStack {
            let padding: CGFloat = 32
            let estimatedWidth = geometry.size.width - padding
            VStack(spacing: 24) {
                buildTitleContentViewStack(estimatedWidth: estimatedWidth)
                buildMessageContentViewStack(estimatedWidth: estimatedWidth)
            }
            .padding(.top, padding)
            .padding(.bottom, padding)
            .frame(width: estimatedWidth, alignment: .center)
            .overlay {
                GeometryReader { geometry in
                    let width = geometry.size.width
                    let height = geometry.size.height
                    let curve: CGFloat = 20

                    let p1 = CGPoint(x: width, y: 0)
                    let p2 = CGPoint(x: curve, y: 0)
                    let p3 = CGPoint(x: 0, y: curve)
                    let p4 = CGPoint(x: 0, y: height - curve)
                    let p5 = CGPoint(x: curve, y: height)
                    let p6 = CGPoint(x: width, y: height)
                    BorderView(coordinates: [p1, p2, p3, p4, p5, p6])
                        .stroke(ColorCollection.gold)
                }
            }
        }
        .frame(width: geometry.size.width, alignment: .trailing)
    }

    private func buildTitleContentViewStack(estimatedWidth: CGFloat) -> some View {
        VStack(spacing: 4) {
            let padding: CGFloat = 35
            let shortTitleFont = FontCollection.font(for: FontCollection.BrilliantCutProB7.bold(size: 11))
            Text(model.shortTitle)
                .accessibilityLabel(model.shortTitle)
                .foregroundColor(ColorCollection.gold)
                .font(shortTitleFont)
                .padding(.leading, padding)
                .padding(.trailing, padding)
                .frame(width: estimatedWidth, alignment: .leading)

            let longTitleFont = FontCollection.font(for: FontCollection.BrilliantCutProB7.medium(size: 22))
            Text(model.longTitle)
                .accessibilityLabel(model.longTitle)
                .foregroundColor(ColorCollection.black)
                .font(longTitleFont)
                .padding(.leading, padding)
                .padding(.trailing, padding)
                .frame(width: estimatedWidth, alignment: .leading)
        }
    }

    private func buildMessageContentViewStack(estimatedWidth: CGFloat) -> some View {
        HStack(spacing: 0) {
            let padding: CGFloat = 35
            let messageContentWidth = estimatedWidth - padding
            VStack(spacing: 14) {
                let messagePadding: CGFloat = 24
                let messageFieldWidth = messageContentWidth - (messagePadding * 2)
                let messageFont = FontCollection.font(for: FontCollection.FancyCutProB7.regular(size: 16))
                Text(model.message)
                    .accessibilityLabel(model.message)
                    .foregroundColor(ColorCollection.black)
                    .font(messageFont)
                    .frame(width: messageFieldWidth, alignment: .leading)

                if let attachment = model.attachment {
                    HStack(spacing: 8) {
                        Image("ic_attachment_gold")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 12, height: 16, alignment: .center)

                        let attachmentFont = FontCollection.font(for: FontCollection.FancyCutProB7.bold(size: 14))
                        Text(attachment)
                            .accessibilityLabel(attachment)
                            .foregroundColor(ColorCollection.black)
                            .font(attachmentFont)
                    }
                    .frame(width: messageFieldWidth, alignment: .leading)
                }
            }
            .padding(24)
            .frame(width: messageContentWidth, alignment: .leading)
            .background(ColorCollection.lightBeige)
        }
        .frame(width: estimatedWidth, alignment: .trailing)
    }
}

struct ResourceReportView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            ResourceReportView(geometry: geometry, model: ResourceReportView.mockData())
        }
    }
}

extension ResourceReportView {
    static func mockData() -> ResourceReportViewModel {
        .init(id: 0,
              shortTitle: "RESOURCE TYPE",
              longTitle: "Repair Creation and Follow-up".uppercased(),
              message: "Nam ultrices dictum nunc at tempus. Praesent bibendum tellus tellus, quis fringilla quam convallis sed lorem ipsum longer sentence bla bla something else.",
              attachment: "PDF / 3.83 MB")
    }
}
