//
//  LoginViewController.swift
//  Flash Chat
//
//  Created by IOS DEV PRO 1 on 04/01/2021.
//

import Firebase
import NVActivityIndicatorView
import UIKit

@available(iOS 11.0, *)
@available(iOS 11.0, *)
class LoginViewController: UIViewController, UITextFieldDelegate {
    var email = String()
    var password = String()
    lazy var loginView: LoginView = {
        let k = LoginView()
        k.loginLabel.addTarget(self, action: #selector(loginPressed), for: .touchUpInside)
        k.translatesAutoresizingMaskIntoConstraints = false
        return k
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
            view.backgroundColor = UIColor(named: Constants.BrandColors.blue)
        constraintsAll()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.barTintColor = view.backgroundColor
    }

    func constraintsAll() {
        view.addSubview(loginView)
        NSLayoutConstraint.activate([
            loginView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 50),
            loginView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 10),
            loginView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -10)
        ])
    }

    @objc func loginPressed() {
        login()
    }

    func login() {
        guard let passwordText = loginView.loginPassword.text, !passwordText.isEmpty else { return }
        guard let emailText = loginView.loginEmail.text, !emailText.isEmpty else { return }
        UIApplication.shared.keyWindow?.startBlockingActivityIndicator()
        Auth.auth().signIn(withEmail: emailText, password: passwordText) { _, error in
            if let e = error {
                ErrorToast(e.localizedDescription)
            } else {
                let controller = ChatViewController()
                self.navigationController?.pushViewController(controller, animated: true)
            }
            UIApplication.shared.keyWindow?.stopBlockingActivityIndicator()
        }
    }
}
