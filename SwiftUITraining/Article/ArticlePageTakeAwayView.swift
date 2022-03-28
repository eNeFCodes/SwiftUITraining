//
//  ArticlePageTakeAwayView.swift
//  SwiftUITraining
//
//  Created by Neil Francis Hipona on 3/25/22.
//

import SwiftUI

extension ArticlePageTakeAwayView {
    struct Model {
        struct TakeAway: Identifiable {
            let id: Int
            let detail: String

            var number: String {
                id > 9 ? "\(id)" : "0\(id)"
            }
        }

        let miniTitle: String
        let title: String
        let infoDate: String
        let infoAuthor: String
        let infoLocation: String
        let infoDetail: String
        let takeAwayTitle: String
        let takeAways: [TakeAway]

        init(miniTitle: String,
             title: String,
             infoDate: String,
             infoAuthor: String,
             infoLocation: String,
             infoDetail: String,
             takeAwayTitle: String = "KEY TAKEAWAYS",
             takeAways: [TakeAway]) {

            self.miniTitle = miniTitle
            self.title = title
            self.infoDate = infoDate
            self.infoAuthor = infoAuthor
            self.infoLocation = infoLocation
            self.infoDetail = infoDetail
            self.takeAwayTitle = takeAwayTitle
            self.takeAways = takeAways
        }
    }
}

struct ArticlePageTakeAwayView: View {

    let model: Model = ArticlePageView.mockTakeAwayData()

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    Image("img_bg_article")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: 200, alignment: .bottom)
                        .clipped()
                    Spacer()
                }
                .ignoresSafeArea()

                VStack(alignment: .leading, spacing: 18) {
                    // title stack
                    VStack(alignment: .leading, spacing: 8) {
                        let miniTitleFont = Font.custom("BrilliantCutProB7-Bold", size: 11)
                        Text(model.miniTitle)
                            .accessibilityLabel(model.miniTitle)
                            .font(miniTitleFont)
                            .foregroundColor(.black)

                        let titleFont = Font.custom("BrilliantCutProB7-Bold", size: 28)
                        Text(model.title)
                            .accessibilityLabel(model.title)
                            .font(titleFont)
                            .foregroundColor(.black)
                    }

                    // detail stack
                    Group {
                        let estimatedWidth = geometry.size.width - 65

                        let infoDateFont = UIFont(name: "FancyCutProB7-Bold", size: 14)!
                        let infoDateHeight = model.infoDate.constrainedSize(with: .init(width: estimatedWidth, height: .infinity),
                                                                            minHeight: 15,
                                                                            attributes: [.font: infoDateFont])

                        let infoAuthorFont = UIFont(name: "FancyCutProB7-Regular", size: 14)!
                        let infoAuthorHeight = model.infoAuthor.constrainedSize(with: .init(width: estimatedWidth, height: .infinity),
                                                                                minHeight: 15,
                                                                                attributes: [.font: infoAuthorFont])

                        let infoLocationFont = UIFont(name: "FancyCutProB7-Bold", size: 14)!
                        let infoLocationHeight = model.infoLocation.constrainedSize(with: .init(width: estimatedWidth, height: .infinity),
                                                                                    minHeight: 15,
                                                                                    attributes: [.font: infoLocationFont])

                        let infoDetailFont = UIFont(name: "FancyCutProB7-Light", size: 29)!
                        let infoDetailHeight = model.infoDetail.constrainedSize(with: .init(width: estimatedWidth, height: .infinity),
                                                                      minHeight: 30,
                                                                      attributes: [.font: infoDetailFont])
                        // 8 * 3 + 24
                        let canvasHeight = infoDateHeight + infoAuthorHeight + infoLocationHeight + 48 + infoDetailHeight

                        HStack(alignment: .top, spacing: 24) {
                            VStack {
                                GeometryReader { geometry in
                                    let p1 = CGPoint(x: 0, y: 0)
                                    let p2 = CGPoint(x: 0, y: geometry.size.height)
                                    BorderView(coordinates: [p1, p2])
                                        .stroke(style: StrokeStyle(lineWidth: 1, dash: [2]))
                                        .foregroundColor(Color.init(hex: "AC9852"))
                                        .frame(width: 1, height: geometry.size.height, alignment: .leading)
                                }
                            }
                            .frame(width: 1, alignment: .leading)

                            VStack(alignment: .leading, spacing: 8) {
                                Text(model.infoDate)
                                    .accessibilityLabel(model.infoDate)
                                    .font(infoDateFont.toFont())
                                    .foregroundColor(.black)
                                Text(model.infoAuthor)
                                    .accessibilityLabel(model.infoAuthor)
                                    .font(infoAuthorFont.toFont())
                                    .foregroundColor(.black)
                                Text(model.infoLocation)
                                    .accessibilityLabel(model.infoLocation)
                                    .font(infoLocationFont.toFont())
                                    .foregroundColor(.black)

                                Spacer()

                                Text(model.infoDetail)
                                    .accessibilityLabel(model.infoDetail)
                                    .font(infoDetailFont.toFont())
                                    .foregroundColor(.black)
                            }
                        }
                        .frame(height: canvasHeight, alignment: .center)
                    }

                    // takeaways
                    Group {
                        let takeawayTitleFont = Font.custom("BrilliantCutProB7-Bold", size: 11)
                        Text(model.takeAwayTitle)
                            .accessibilityLabel(model.takeAwayTitle)
                            .font(takeawayTitleFont)
                            .foregroundColor(.black)
                            .padding(.top, 30)

                        VStack(spacing: 24) {
                            let estimatedWidth = geometry.size.width - 98
                            let numberFont = Font.custom("FancyCutCondProB7-Bold", size: 44)
                            let takeAwayDFont = UIFont(name: "FancyCutProB7-Regular", size: 18)!

                            ForEach(model.takeAways, id: \.id) { takeAway in
                                let takeAwayDetailHeight = takeAway.detail.constrainedSize(with: .init(width: estimatedWidth, height: .infinity),
                                                                                           minHeight: 50,
                                                                                           attributes: [.font: takeAwayDFont])
                                HStack(spacing: 8) {
                                    Text(takeAway.number)
                                        .accessibilityLabel(takeAway.number)
                                        .foregroundColor(Color.init(hex: "C10016"))
                                        .font(numberFont)
                                        .frame(width: 50, alignment: .center)

                                    Text(takeAway.detail)
                                        .accessibilityLabel(takeAway.detail)
                                        .foregroundColor(.black)
                                        .font(takeAwayDFont.toFont())
                                        .frame(width: estimatedWidth, height: abs(takeAwayDetailHeight), alignment: .leading)
                                }
                            }
                        }
                    }
                }
                .padding(20)
                .frame(width: abs(geometry.size.width))
            }
            .background(Color.init(hex: "DCD7CA"))
        }
    }
}

struct ArticlePageTakeAwayView_Previews: PreviewProvider {
    static var previews: some View {
        ArticlePageTakeAwayView()
    }
}
