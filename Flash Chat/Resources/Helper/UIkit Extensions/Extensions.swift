//
//  Extensions.swift
//  Flash Chat
//
//  Created by IOS DEV PRO 1 on 04/01/2021.
//

import Foundation
import UIKit
extension Notification {
    var getKeyboardHeight: CGFloat {
        let userInfo: NSDictionary = self.userInfo! as NSDictionary
        let keyboardFrame = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as? NSValue
        let keyboardRectangle = keyboardFrame?.cgRectValue
        return keyboardRectangle?.height ?? .zero
    }
}

extension UIColor {
    class var textColor: UIColor {
        return UIColor(hexString: "3E425F")
    }

    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

extension UIButton {
    func setCustomButtonStyle(title: String, titleColor: UIColor = .white, backgroundColor: UIColor){
        layer.backgroundColor = backgroundColor.cgColor
        layer.cornerRadius = 20
        let centeredParagraphStyle = NSMutableParagraphStyle()
        centeredParagraphStyle.alignment = .center
        let attributedTitle = NSAttributedString(string: title,
                                                 attributes: [
                                                    NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 25),
                                                    NSAttributedString.Key.foregroundColor: titleColor,
                                                    NSAttributedString.Key.paragraphStyle: centeredParagraphStyle
                                                 ])
        setAttributedTitle(attributedTitle, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
    }

}
extension UITextField  {
    func setCustomPlaceholderTextStyle(title: String, foregroundColor: UIColor = .lightGray, backGroundColor : UIColor = #colorLiteral(red: 0.999904573, green: 1, blue: 0.9998808503, alpha: 1) , contentType: UITextContentType){
        backgroundColor = backGroundColor
        let centeredParagraphStyle = NSMutableParagraphStyle()
        centeredParagraphStyle.alignment = .center
                let attributedPlaceholderText = NSAttributedString(string: title, attributes: [NSAttributedString.Key.foregroundColor: foregroundColor,
                                                                                       NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.paragraphStyle : centeredParagraphStyle])
        attributedPlaceholder = attributedPlaceholderText
        textAlignment = .center
        isUserInteractionEnabled = true
        textContentType = contentType
        layer.cornerRadius = 25
        textColor = .black
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
extension String {
    func localize() -> String {
        return NSLocalizedString(self, comment: "")
    }
}

final class InputAccessoryView: UIView {
    override var intrinsicContentSize: CGSize {
        return .zero
    }
}
extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UITableViewHeaderFooterView {
    static var identifier: String {
        return String(describing: self)
    }
}
extension Date {
    static var yesterday: Date { return Date().dayBefore }
    static var tomorrow:  Date { return Date().dayAfter }
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    var month: Int {
        return Calendar.current.component(.month,  from: self)
    }
    var isLastDayOfMonth: Bool {
        return dayAfter.month != month
    }
}
