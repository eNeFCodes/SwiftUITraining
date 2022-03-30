//
//  Font+Ext.swift
//  SwiftUITraining
//
//  Created by Neil Francis Hipona on 3/28/22.
//

import Foundation
import SwiftUI
import UIKit

protocol FontCollectionProtocol {
    var name: String { get }
    var size: CGFloat { get }
}

struct FontCollection {
    enum BrilliantCutProB7: FontCollectionProtocol {
        case black(size: CGFloat)
        case bold(size: CGFloat)
        case light(size: CGFloat)
        case medium(size: CGFloat)
        case regular(size: CGFloat)
        case thin(size: CGFloat)

        var name: String {
            switch self {
            case .black:
                return "BrilliantCutProB7-Black"
            case .bold:
                return "BrilliantCutProB7-Bold"
            case .light:
                return "BrilliantCutProB7-Light"
            case .medium:
                return "BrilliantCutProB7-Medium"
            case .regular:
                return "BrilliantCutProB7-Regular"
            case .thin:
                return "BrilliantCutProB7-Thin"
            }
        }

        var size: CGFloat {
            switch self {
            case .black(let size):
                return size
            case .bold(let size):
                return size
            case .light(let size):
                return size
            case .medium(let size):
                return size
            case .regular(let size):
                return size
            case .thin(let size):
                return size
            }
        }
    }

    enum FancyCutCondProB7: FontCollectionProtocol {
        case bold(size: CGFloat)
        case boldItalic(size: CGFloat)
        case light(size: CGFloat)
        case lightItalic(size: CGFloat)
        case medium(size: CGFloat)
        case mediumItalic(size: CGFloat)
        case regular(size: CGFloat)
        case regularItalic(size: CGFloat)
        case thin(size: CGFloat)
        case thinItalic(size: CGFloat)

        var name: String {
            switch self {
            case .bold:
                return "FancyCutCondProB7-Bold"
            case .boldItalic:
                return "FancyCutCondProB7-BoldItalic"
            case .light:
                return "FancyCutCondProB7-Light"
            case .lightItalic:
                return "FancyCutCondProB7-LightItalic"
            case .medium:
                return "FancyCutCondProB7-Medium"
            case .mediumItalic:
                return "FancyCutCondProB7-MediumItalic"
            case .regular:
                return "FancyCutCondProB7-Regular"
            case .regularItalic:
                return "FancyCutCondProB7-RegularItalic"
            case .thin:
                return "FancyCutCondProB7-Thin"
            case .thinItalic:
                return "FancyCutCondProB7-ThinItalic"
            }
        }

        var size: CGFloat {
            switch self {
            case .bold(let size):
                return size
            case .boldItalic(let size):
                return size
            case .light(let size):
                return size
            case .lightItalic(let size):
                return size
            case .medium(let size):
                return size
            case .mediumItalic(let size):
                return size
            case .regular(let size):
                return size
            case .regularItalic(let size):
                return size
            case .thin(let size):
                return size
            case .thinItalic(let size):
                return size
            }
        }
    }

    enum FancyCutExtProB7: FontCollectionProtocol {
        case bold(size: CGFloat)
        case boldItalic(size: CGFloat)
        case light(size: CGFloat)
        case lightItalic(size: CGFloat)
        case medium(size: CGFloat)
        case mediumItalic(size: CGFloat)
        case regular(size: CGFloat)
        case regularItalic(size: CGFloat)
        case thin(size: CGFloat)
        case thinItalic(size: CGFloat)

        var name: String {
            switch self {
            case .bold:
                return "FancyCutExtProB7-Bold"
            case .boldItalic:
                return "FancyCutExtProB7-BoldItalic"
            case .light:
                return "FancyCutExtProB7-Light"
            case .lightItalic:
                return "FancyCutExtProB7-LightItalic"
            case .medium:
                return "FancyCutExtProB7-Medium"
            case .mediumItalic:
                return "FancyCutExtProB7-MediumItalic"
            case .regular:
                return "FancyCutExtProB7-Regular"
            case .regularItalic:
                return "FancyCutExtProB7-RegularItalic"
            case .thin:
                return "FancyCutExtProB7-Thin"
            case .thinItalic:
                return "FancyCutExtProB7-ThinItalic"
            }
        }

        var size: CGFloat {
            switch self {
            case .bold(let size):
                return size
            case .boldItalic(let size):
                return size
            case .light(let size):
                return size
            case .lightItalic(let size):
                return size
            case .medium(let size):
                return size
            case .mediumItalic(let size):
                return size
            case .regular(let size):
                return size
            case .regularItalic(let size):
                return size
            case .thin(let size):
                return size
            case .thinItalic(let size):
                return size
            }
        }
    }

    enum FancyCutProB7: FontCollectionProtocol {
        case bold(size: CGFloat)
        case boldItalic(size: CGFloat)
        case light(size: CGFloat)
        case lightItalic(size: CGFloat)
        case medium(size: CGFloat)
        case mediumItalic(size: CGFloat)
        case regular(size: CGFloat)
        case regularItalic(size: CGFloat)
        case thin(size: CGFloat)
        case thinItalic(size: CGFloat)

        var name: String {
            switch self {
            case .bold:
                return "FancyCutProB7-Bold"
            case .boldItalic:
                return "FancyCutProB7-BoldItalic"
            case .light:
                return "FancyCutProB7-Light"
            case .lightItalic:
                return "FancyCutProB7-LightItalic"
            case .medium:
                return "FancyCutProB7-Medium"
            case .mediumItalic:
                return "FancyCutProB7-MediumItalic"
            case .regular:
                return "FancyCutProB7-Regular"
            case .regularItalic:
                return "FancyCutProB7-RegularItalic"
            case .thin:
                return "FancyCutProB7-Thin"
            case .thinItalic:
                return "FancyCutProB7-ThinItalic"
            }
        }

        var size: CGFloat {
            switch self {
            case .bold(let size):
                return size
            case .boldItalic(let size):
                return size
            case .light(let size):
                return size
            case .lightItalic(let size):
                return size
            case .medium(let size):
                return size
            case .mediumItalic(let size):
                return size
            case .regular(let size):
                return size
            case .regularItalic(let size):
                return size
            case .thin(let size):
                return size
            case .thinItalic(let size):
                return size
            }
        }
    }

    static func font(for model: FontCollectionProtocol) -> Font {
        return Font.custom(model.name, size: model.size)
    }

    static func uiFont(for model: FontCollectionProtocol) -> UIFont? {
        return UIFont(name: model.name, size: model.size)
    }
}

extension UIFont {
    func toFont() -> Font {
        let castedFont = Font(self as CTFont)
        return castedFont
    }
}
