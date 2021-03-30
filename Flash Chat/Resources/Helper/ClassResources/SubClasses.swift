//
//  SubClasses.swift
//  Flash Chat
//
//  Created by IOS DEV PRO 1 on 23/03/2021.
//

import Foundation
import UIKit

final class AccessoryViewUITextField: UITextField {
    let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        super.placeholderRect(forBounds: bounds)
        return bounds.inset(by: padding)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        super.textRect(forBounds: bounds)
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        super.editingRect(forBounds: bounds)
        return bounds.inset(by: padding)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class SubClassUILabel: UILabel {
    let menu = UIMenuController.shared
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }
    
    func sharedInit() {
        isUserInteractionEnabled = true
        addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(showMenu)))
    }
    
    @objc func showMenu(sender: Any?) {
        becomeFirstResponder()
        if !menu.isMenuVisible {
            menu.showMenu(from: self, rect: bounds)
        }
    }

    override func copy(_ sender: Any?) {
        let board = UIPasteboard.general
        board.string = text
        menu.hideMenu()
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(UIResponderStandardEditActions.copy(_:)) {
            return true
        }
        return false
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
