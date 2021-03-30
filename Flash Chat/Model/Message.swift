//
//  Message.swift
//  Flash Chat
//
//  Created by IOS DEV PRO 1 on 18/03/2021.
//

import Foundation
struct Message {
    let sender: String?
    let body: String?
    let date: Date?
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.dateFormat = "MMMM dd, YYYY"
        return dateFormatter.string(from: date ?? Date())
    }

    static func == (lhs: Message, rhs: Message) -> Bool {
        return lhs.formattedDate == rhs.formattedDate
    }

    var section: Int {
        if formattedDate == formattedDate {
            return .zero
        } else {
            return 1
        }
    }
}
