//
//  WelcomeViewController.swift
//  Flash Chat
//
//  Created by IOS DEV PRO 1 on 04/01/2021.
//

import UIKit

class WelcomeViewController: UIViewController {
    var logoTimer: Timer?
    var charIndex = 0.0
    let logoName = NSLocalizedString("txt_logo_text", comment: "")
    lazy var welcomeView: WelcomeView = {
        let k = WelcomeView()
        k.translatesAutoresizingMaskIntoConstraints = false
        return k
    }()
    
    lazy var registerBtn: UIButton = {
        let k = UIButton()
        k.isUserInteractionEnabled = true
        k.setCustomButtonStyle(title: "Register", titleColor: UIColor(named: Constants.BrandColors.blue)!, backgroundColor: UIColor(named: Constants.BrandColors.lightBlue)!)
        k.addTarget(self, action: #selector(regBtnPressed), for: .touchUpInside)
        return k
    }()
    
    lazy var loginBtn: UIButton = {
        let k = UIButton()
        k.isUserInteractionEnabled = true
            k.setCustomButtonStyle(title: "Login", backgroundColor: UIColor(named: Constants.BrandColors.blue)!)

        k.addTarget(self, action: #selector(logBtnPressed), for: .touchUpInside)
        return k
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        for (_, v) in logoName.enumerated() {
            logoTimer = Timer.scheduledTimer(withTimeInterval: 0.2 * charIndex, repeats: false) { _ in
                self.welcomeView.logoLabel.text?.append(v)
            }
            charIndex += 1
        }
        constraintsAll()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    func constraintsAll() {
        view.addSubview(welcomeView)
        view.addSubview(registerBtn)
        view.addSubview(loginBtn)
        NSLayoutConstraint.activate([
            welcomeView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            welcomeView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 20),
            welcomeView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -20),
            
            registerBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.DOUBLE_PADDING + 4),
            registerBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -(Constants.DOUBLE_PADDING + 4)),
            
            loginBtn.topAnchor.constraint(equalTo: registerBtn.bottomAnchor, constant: Constants.DEFAULT_PADDING),
            loginBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.DOUBLE_PADDING + 4),
            loginBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -(Constants.DOUBLE_PADDING + 4)),
            loginBtn.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -(Constants.DOUBLE_PADDING + 4))
        ])
    }

    @objc func regBtnPressed() {
        let nav = RegisterViewController()
        navigationController?.pushViewController(nav, animated: true)
    }

    @objc func logBtnPressed() {
        let nav = LoginViewController()
        navigationController?.pushViewController(nav, animated: true)
    }
}
