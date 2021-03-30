//
//  Constants.swift
//  Flash Chat
//
//  Created by IOS DEV PRO 1 on 17/03/2021.
//

import Foundation
import UIKit

struct Constants {
    static let DEFAULT_PADDING: CGFloat  = 8
    static let DOUBLE_PADDING: CGFloat = 16

enum BrandColors {
    static let purple = "BrandPurple"
    static let lightPurple = "BrandLightPurple"
    static let blue = "BrandBlue"
    static let lightBlue = "BrandLightBlue"
}
    
struct FStore {
    static let collectionName = "messages"
    static let senderField = "sender"
    static let bodyField = "body"
    static let dateField = "date"
}
}


