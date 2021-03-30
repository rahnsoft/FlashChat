//
//  RegisterView.swift
//  Flash Chat
//
//  Created by IOS DEV PRO 1 on 04/01/2021.
//

import Foundation
import UIKit

class RegisterView: UIView {
    lazy var email: UITextField = {
        let k = UITextField()
        k.delegate = self
        k.setCustomPlaceholderTextStyle(title: "txt_email".localize(), contentType: .emailAddress)
        return k
    }()
    
    lazy var password: UITextField = {
        let k = UITextField()
        k.delegate = self
        if #available(iOS 11.0, *) {
            k.setCustomPlaceholderTextStyle(title: "txt_password".localize(), contentType: .password )
        } else {
            // Fallback on earlier versions
        }
        return k
    }()
    
    lazy var registerLabel: UIButton = {
        let k = UIButton()
            k.setCustomButtonStyle(title: "txt_register".localize(),titleColor: UIColor(named: Constants.BrandColors.blue)!, backgroundColor: .clear)
        return k
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        constraintsAll()
    }
    func constraintsAll(){
        addSubview(email)
        addSubview(password)
        addSubview(registerLabel)
        NSLayoutConstraint.activate([
            email.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            email.leadingAnchor.constraint(equalTo: leadingAnchor),
            email.trailingAnchor.constraint(equalTo: trailingAnchor),
            email.heightAnchor.constraint(equalToConstant: 50),
            email.bottomAnchor.constraint(equalTo: password.topAnchor, constant: -10),
            
            password.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 10),
            password.leadingAnchor.constraint(equalTo: leadingAnchor),
            password.trailingAnchor.constraint(equalTo: trailingAnchor),
            password.heightAnchor.constraint(equalToConstant: 50),
            password.bottomAnchor.constraint(equalTo: registerLabel.topAnchor, constant: -20),
            
            registerLabel.topAnchor.constraint(equalTo: password.bottomAnchor, constant: 20),
            registerLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            registerLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension RegisterView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
    }
}
