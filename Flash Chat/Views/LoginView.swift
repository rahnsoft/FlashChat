//
//  RegisterView.swift
//  Flash Chat
//
//  Created by IOS DEV PRO 1 on 04/01/2021.
//

import Foundation
import UIKit

class LoginView: UIView {
    lazy var loginEmail: UITextField = {
        let k = UITextField()
        k.delegate = self
        k.text = "Test@gmail.com"
        k.setCustomPlaceholderTextStyle(title: "txt_email".localize(), contentType: .emailAddress)
        return k
    }()
    
    lazy var loginPassword: UITextField = {
        let k = UITextField()
        k.delegate = self
        k.text = "12345678"
        k.setCustomPlaceholderTextStyle(title: "txt_password".localize(), contentType: .password)
        return k
    }()
    
    lazy var loginLabel: UIButton = {
        let k = UIButton()
        k.setCustomButtonStyle(title: "txt_login".localize(), titleColor: #colorLiteral(red: 0.999904573, green: 1, blue: 0.9998808503, alpha: 1), backgroundColor: .clear)
        return k
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        constraintsAll()
    }

    func constraintsAll() {
        addSubview(loginEmail)
        addSubview(loginPassword)
        addSubview(loginLabel)
        NSLayoutConstraint.activate([
            loginEmail.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            loginEmail.leadingAnchor.constraint(equalTo: leadingAnchor),
            loginEmail.trailingAnchor.constraint(equalTo: trailingAnchor),
            loginEmail.heightAnchor.constraint(equalToConstant: 50),
            loginEmail.bottomAnchor.constraint(equalTo: loginPassword.topAnchor, constant: -10),
            
            loginPassword.topAnchor.constraint(equalTo: loginEmail.bottomAnchor, constant: 10),
            loginPassword.leadingAnchor.constraint(equalTo: leadingAnchor),
            loginPassword.trailingAnchor.constraint(equalTo: trailingAnchor),
            loginPassword.heightAnchor.constraint(equalToConstant: 50),
            loginPassword.bottomAnchor.constraint(equalTo: loginLabel.topAnchor, constant: -20),
            
            loginLabel.topAnchor.constraint(equalTo: loginPassword.bottomAnchor, constant: 20),
            loginLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            loginLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LoginView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
    }
}
