//
//  TagViewModel.swift
//  SwiftUITraining
//
//  Created by Neil Francis Hipona on 4/11/22.
//

import Foundation
import SwiftUI

class TagViewModel: ObservableObject, Equatable {
    static func == (lhs: TagViewModel, rhs: TagViewModel) -> Bool {
        return lhs.id == rhs.id
    }

    class Tag: ObservableObject, Identifiable {
        let id: Int
        let name: String
        @Published var isSelected: Bool

        init(id: Int, name: String, isSelected: Bool = false) {
            self.id = id
            self.name = name
            self.isSelected = isSelected
        }
    }

    let id: Int
    let title: String?
    @Published var tags: [Tag]
    @Published var sections: [TagViewSection] = []
    var maxCanvasWidth: CGFloat
    var minCanvasHeight: CGFloat
    var padding: CGFloat

    init(id: Int,
         title: String,
         tags: [Tag],
         maxCanvasWidth: CGFloat = TagView.MaxCanvasWidth,
         minCanvasHeight: CGFloat = 32,
         padding: CGFloat = 16) {

        self.id = id
        self.title = title
        self.tags = tags

        self.maxCanvasWidth = maxCanvasWidth
        self.minCanvasHeight = minCanvasHeight
        self.padding = padding

        buildSections(maxCanvasWidth: maxCanvasWidth, minCanvasHeight: minCanvasHeight, padding: padding)
    }

    func updateSelected(with t: Tag) {
        tags = tags.map { tag in
            let isSelected = tag.id == t.id
            tag.isSelected = isSelected
            return tag
        }
    }

    private func buildSections(maxCanvasWidth: CGFloat = TagView.MaxCanvasWidth, minCanvasHeight: CGFloat = 32, padding: CGFloat = 16) {
        sections = []
        let estimatedWidth = maxCanvasWidth - (padding * 2)
        let titleFont = FontCollection.uiFont(for: FontCollection.BrilliantCutProB7.bold(size: 11))!
        let attributes: [NSAttributedString.Key: Any] = [.font: titleFont]

        for tag in tags {
            let resultSize = tag.name.constrainedSize(in: .init(width: estimatedWidth, height: .infinity),
                                                      minHeight: minCanvasHeight,
                                                      attributes: attributes)
            let resultWidth = resultSize.width + (padding * 2)
            let tagItem = TagViewRow(item: tag,
                                     itemCanvas: .init(width: resultWidth, height: resultSize.height))

            if let lastSection = sections.last {
                if lastSection.shouldDrawItemInNewSection(itemCanvasWidth: resultWidth, maxCanvasWidth: maxCanvasWidth) {
                    let newSection = TagViewSection(section: sections.count, rows: [tagItem])
                    sections.append(newSection)
                } else {
                    tagItem.updateIndex(newIndex: lastSection.newRowIndex())
                    lastSection.rows.append(tagItem)
                }
            } else {
                let newSection = TagViewSection(section: sections.count, rows: [tagItem])
                sections.append(newSection)
            }
        }
    }
}

extension TagView {
    static var MaxCanvasWidth: CGFloat {
        UIScreen.main.bounds.size.width - 64
    }
}

class TagViewSection: ObservableObject, Identifiable {
    var section: Int
    @Published var rows: [TagViewRow]

    init(section: Int, rows: [TagViewRow]) {
        self.section = section
        self.rows = rows
    }

    func shouldDrawItemInNewSection(itemCanvasWidth: CGFloat, maxCanvasWidth: CGFloat, interItemPadding: CGFloat = 16) -> Bool {
        var rowItemWidth = rows.reduce(into: CGFloat.zero) { partialResult, tag in
            partialResult += tag.itemCanvas.width
        }
        let interItemSpacing = interItemPadding * CGFloat(rows.count)
        rowItemWidth += interItemSpacing
        rowItemWidth += itemCanvasWidth

        return rowItemWidth > maxCanvasWidth
    }

    func newRowIndex() -> Int {
        rows.count
    }
}

class TagViewRow: ObservableObject {
    var index: Int
    @ObservedObject var item: TagViewModel.Tag
    let itemCanvas: CGSize

    init(index: Int = 0, item: TagViewModel.Tag, itemCanvas: CGSize) {
        self.index = index
        self.item = item
        self.itemCanvas = itemCanvas
    }

    func updateIndex(newIndex: Int) {
        index = newIndex
    }
}
