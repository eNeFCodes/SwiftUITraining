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

    struct Tag: Identifiable {
        let id: Int
        let name: String
        var isSelected: Bool

        init(id: Int, name: String, isSelected: Bool = false) {
            self.id = id
            self.name = name
            self.isSelected = isSelected
        }
    }

    let id: Int
    let title: String?
    @Published var tags: [Tag]

    init(id: Int, title: String, tags: [Tag]) {
        self.id = id
        self.title = title
        self.tags = tags
    }

    func updateSelected(with tag: Tag) {
        tags = tags.map { i in
            let isSelected = tag.id == i.id
            return Tag(id: i.id, name: i.name, isSelected: isSelected)
        }
    }

    @discardableResult
    func buildSections(maxCanvasWidth: CGFloat, minCanvasHeight: CGFloat = 32, padding: CGFloat = 16) -> [TagViewSection] {
        var sections: [TagViewSection] = []
        let estimatedWidth = maxCanvasWidth - (padding * 2)
        let titleFont = FontCollection.uiFont(for: FontCollection.BrilliantCutProB7.bold(size: 11))!
        let attributes: [NSAttributedString.Key: Any] = [.font: titleFont]

        for tag in tags {
            let resultSize = tag.name.constrainedSize(in: .init(width: estimatedWidth, height: .infinity),
                                                      minHeight: 32,
                                                      attributes: attributes)
            let resultWidth = resultSize.width + (padding * 2)
            var tagItem = TagViewRow(item: tag,
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

        return sections
    }
}

class TagViewSection: Identifiable {
    var section: Int
    var rows: [TagViewRow]

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

struct TagViewRow {
    var index: Int
    let item: TagViewModel.Tag
    let itemCanvas: CGSize

    init(index: Int = 0, item: TagViewModel.Tag, itemCanvas: CGSize) {
        self.index = index
        self.item = item
        self.itemCanvas = itemCanvas
    }

    mutating func updateIndex(newIndex: Int) {
        index = newIndex
    }
}
