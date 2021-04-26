//
//  RegsiterViewController.swift
//  Flash Chat
//
//  Created by IOS DEV PRO 1 on 04/01/2021.
//

import Firebase
import UIKit

@available(iOS 11.0, *)
class RegisterViewController: UIViewController {
    lazy var registerView: RegisterView = {
        let k = RegisterView()
        k.layer.shadowRadius = 25
        k.layer.shadowOffset = CGSize(width: 0, height: 3)
        k.layer.shadowOpacity = 1
        k.layer.shadowColor = UIColor.lightGray.cgColor
        k.registerLabel.addTarget(self, action: #selector(register), for: .touchUpInside)
        k.translatesAutoresizingMaskIntoConstraints = false
        return k
    }()

    lazy var t: LoginViewController = {
        let k = LoginViewController()
        return k
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 11.0, *) {
            view.backgroundColor = UIColor(named: "BrandLightBlue")
        } else {
            // Fallback on earlier versions
        }
        constraintsAll()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }

    func constraintsAll() {
        view.addSubview(registerView)
        NSLayoutConstraint.activate([
            registerView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 50),
            registerView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 10),
            registerView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -10),
        ])
    }
    
    @objc func register(_ sender: UIButton) {
        if let email = registerView.email.text, !email.isEmpty, let passWord = registerView.password.text, !passWord.isEmpty {
            Auth.auth().createUser(withEmail: email, password: passWord) { _, error in
                if let e = error {
                    ErrorToast(String(e.localizedDescription), type: .error)
                } else {
                    SuccessToast("Success", type: .success)
                    let nav = ChatViewController()
                    self.navigationController?.pushViewController(nav, animated: true)
                }
            }
        } else {
            ErrorToast("Email or Password cannot be empty", type: .error)
        }
    }
    
    func updateColor() {
        view.backgroundColor = .yellow
    }
}
