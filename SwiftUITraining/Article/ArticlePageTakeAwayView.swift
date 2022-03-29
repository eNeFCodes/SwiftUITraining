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
        let image: Image?
        let infoDate: String
        let infoAuthor: String
        let infoLocation: String
        let infoDetail: String
        let takeAwayTitle: String
        let takeAways: [TakeAway]

        var hasImage: Bool {
            guard let _ = image else { return false }
            return true
        }

        init(miniTitle: String,
             title: String,
             image: Image? = nil,
             infoDate: String,
             infoAuthor: String,
             infoLocation: String,
             infoDetail: String,
             takeAwayTitle: String = "KEY TAKEAWAYS",
             takeAways: [TakeAway]) {

            self.miniTitle = miniTitle
            self.title = title
            self.image = image
            self.infoDate = infoDate
            self.infoAuthor = infoAuthor
            self.infoLocation = infoLocation
            self.infoDetail = infoDetail
            self.takeAwayTitle = takeAwayTitle
            self.takeAways = takeAways
        }

        func estimatedHeight(geometry: GeometryProxy) -> CGFloat {
            var frameHeight: CGFloat = 40

            // title stack
            let titleFont = UIFont(name: "BrilliantCutProB7-Bold", size: 28)!
            let estimatedWidth = geometry.size.width - 40
            let headerTopPadding: CGFloat = hasImage ? 265 : 91
            let headerBotPadding: CGFloat = hasImage ? 40 : 0
            let titleHeight = title.constrainedSize(with: .init(width: estimatedWidth, height: .infinity),
                                                    minHeight: 28,
                                                    attributes: [.font: titleFont])
            frameHeight += (headerTopPadding + 23 + titleHeight + headerBotPadding)


            // detail stack
            let infoEstimatedWidth = geometry.size.width - 65
            let infoDateFont = UIFont(name: "FancyCutProB7-Bold", size: 14)!
            let infoDateHeight = infoDate.constrainedSize(with: .init(width: infoEstimatedWidth, height: .infinity),
                                                          minHeight: 15,
                                                          attributes: [.font: infoDateFont])

            let infoAuthorFont = UIFont(name: "FancyCutProB7-Regular", size: 14)!
            let infoAuthorHeight = infoAuthor.constrainedSize(with: .init(width: infoEstimatedWidth, height: .infinity),
                                                              minHeight: 15,
                                                              attributes: [.font: infoAuthorFont])

            let infoLocationFont = UIFont(name: "FancyCutProB7-Bold", size: 14)!
            let infoLocationHeight = infoLocation.constrainedSize(with: .init(width: infoEstimatedWidth, height: .infinity),
                                                                  minHeight: 15,
                                                                  attributes: [.font: infoLocationFont])

            let infoDetailFont = UIFont(name: "FancyCutProB7-Light", size: 29)!
            let infoDetailHeight = infoDetail.constrainedSize(with: .init(width: infoEstimatedWidth, height: .infinity),
                                                              minHeight: 30,
                                                              attributes: [.font: infoDetailFont])
            // 8 * 3 + 24
            let canvasHeight = infoDateHeight + infoAuthorHeight + infoLocationHeight + 48 + infoDetailHeight
            frameHeight += canvasHeight

            // takeaway
            frameHeight += 30 + 15

            let takeAwayEstimatedWidth = geometry.size.width - 98
            let takeAwayDFont = UIFont(name: "FancyCutProB7-Regular", size: 18)!

            takeAways.forEach { takeAway in
                let takeAwayDetailHeight = takeAway.detail.constrainedSize(with: .init(width: takeAwayEstimatedWidth, height: .infinity),
                                                                           minHeight: 50,
                                                                           attributes: [.font: takeAwayDFont])
                frameHeight += (24 + takeAwayDetailHeight)
            }

            return frameHeight + 36
        }
    }
}

struct ArticlePageTakeAwayView: View {

//    let model: Model = ArticlePageView.mockTakeAwayData()
    let model: Model = ArticlePageView.mockTakeAwayImageData()

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // title stack
                let titleFont = UIFont(name: "BrilliantCutProB7-Bold", size: 28)!
                let estimatedWidth = geometry.size.width - 40
                let headerTopPadding: CGFloat = model.hasImage ? 265 : 91
                let headerBotPadding: CGFloat = model.hasImage ? 40 : 0
                let titleHeight = model.title.constrainedSize(with: .init(width: estimatedWidth, height: .infinity),
                                                              minHeight: 28,
                                                              attributes: [.font: titleFont])
                
                VStack {
                    if let image = model.image {
                        let bgImageFrameHeight = 20 + headerTopPadding + 15 + 8 + titleHeight + headerBotPadding
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geometry.size.width, height: bgImageFrameHeight, alignment: .bottom)
                            .clipped()
                    } else {
                        let bgImageFrameHeight = headerTopPadding + 15 + 8 + titleHeight - 20
                        Image("img_bg_article")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geometry.size.width, height: bgImageFrameHeight, alignment: .bottom)
                            .clipped()
                    }
                    Spacer()
                }
                
                VStack(alignment: .leading, spacing: 18) {
                    // title stack
                    VStack(alignment: .leading, spacing: 8) {
                        let miniTitleFont = Font.custom("BrilliantCutProB7-Bold", size: 11)
                        Text(model.miniTitle)
                            .accessibilityLabel(model.miniTitle)
                            .font(miniTitleFont)
                            .frame(width: abs(estimatedWidth), height: 15, alignment: .leading)
                        
                        Text(model.title)
                            .accessibilityLabel(model.title)
                            .font(titleFont.toFont())
                            .frame(width: abs(estimatedWidth), height: titleHeight, alignment: .leading)
                    }
                    .foregroundColor(model.hasImage ? .white : .black)
                    .padding(.top, headerTopPadding)
                    .padding(.bottom, headerBotPadding)
                    
                    // detail stack
                    detailStack(geometry: geometry)
                    
                    // takeaways
                    takeAwayStack(geometry: geometry)
                }
                .padding(20)
                .frame(width: abs(geometry.size.width))
            }
            .frame(width: abs(geometry.size.width), height: model.estimatedHeight(geometry: geometry), alignment: .top)
            .background(Color.init(hex: "DCD7CA"))
        }
    }

    private func detailStack(geometry: GeometryProxy) -> some View {
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
    }

    private func takeAwayStack(geometry: GeometryProxy) -> some View {
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
                            .frame(width: abs(estimatedWidth), height: abs(takeAwayDetailHeight), alignment: .leading)
                    }
                }
            }
        }
    }
}

struct ArticlePageTakeAwayView_Previews: PreviewProvider {
    static var previews: some View {
        ArticlePageTakeAwayView()
    }
}
