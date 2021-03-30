//
//  ChatView.swift
//  Flash Chat
//
//  Created by IOS DEV PRO 1 on 04/01/2021.
//

import Foundation
import UIKit

class ChatView: UIView {
    lazy var inputMessagevIew: UIView = {
        let i = UIView()
        i.backgroundColor = #colorLiteral(red: 0.6971203685, green: 0.3157409728, blue: 0.9535165429, alpha: 1)
        i.translatesAutoresizingMaskIntoConstraints = false
        return i
    }()
    
    lazy var inputMessage: UITextView = {
        let tv = UITextView()
        let newPosition  = tv.beginningOfDocument
        tv.selectedTextRange = tv.textRange(from: newPosition, to: newPosition)
        tv.textColor = .lightGray
        tv.text =  "txt_enter_message".localize()
        tv.font = UIFont.systemFont(ofSize: 12)
        tv.textAlignment = .natural
        tv.backgroundColor = .white
        tv.layer.cornerRadius = 5
        tv.autoresizingMask = .flexibleHeight
        tv.sizeToFit()
        tv.clipsToBounds = true
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    lazy var sendBtn: UIButton = {
        let b = UIButton()
        b.setCustomButtonStyle(title: "", titleColor: .white, backgroundColor: .clear)
        b.setImage(UIImage(systemName: "paperplane.fill"), for: .normal)
        b.imageView?.contentMode = .scaleAspectFill
        b.tintColor = .white
        b.isEnabled = false
        b.contentMode = .scaleAspectFill
        b.contentHorizontalAlignment = .fill
        b.contentVerticalAlignment = .fill
        return b
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(inputMessagevIew)
        inputMessagevIew.addSubview(inputMessage)
        inputMessagevIew.addSubview(sendBtn)
        
        inputMessagevIew.topAnchor.constraint(equalTo: topAnchor).isActive = true
        inputMessagevIew.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        inputMessagevIew.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        inputMessagevIew.heightAnchor.constraint(equalToConstant: 80).isActive = true
        inputMessagevIew.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        inputMessage.topAnchor.constraint(equalTo: inputMessagevIew.topAnchor, constant: 20).isActive = true
        inputMessage.leadingAnchor.constraint(equalTo: inputMessagevIew.layoutMarginsGuide.leadingAnchor).isActive = true
        inputMessage.trailingAnchor.constraint(equalTo: sendBtn.leadingAnchor, constant: -10).isActive = true
        inputMessage.bottomAnchor.constraint(equalTo: inputMessagevIew.bottomAnchor, constant: -20).isActive = true
        
        sendBtn.centerYAnchor.constraint(equalTo: inputMessage.centerYAnchor).isActive = true
        sendBtn.widthAnchor.constraint(equalToConstant: 40).isActive = true
        sendBtn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        sendBtn.leadingAnchor.constraint(equalTo: inputMessage.trailingAnchor, constant: 10).isActive = true
        sendBtn.trailingAnchor.constraint(equalTo: inputMessagevIew.trailingAnchor, constant: -10).isActive = true
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
