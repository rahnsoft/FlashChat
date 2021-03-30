//
//  WelcomeView.swift
//  Flash Chat
//
//  Created by IOS DEV PRO 1 on 04/01/2021.
//

import Foundation
import UIKit
class WelcomeView: UIView {
    lazy var logoLabel: UILabel = {
        let k = UILabel()
        k.text = ""
        k.textColor = UIColor(named: Constants.BrandColors.blue)
        k.font = UIFont.boldSystemFont(ofSize: 45)
        k.contentMode = .scaleAspectFit
        k.translatesAutoresizingMaskIntoConstraints = false
        return k
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
    constraintsAll()
    }

    func constraintsAll(){
        addSubview(logoLabel)
        NSLayoutConstraint.activate([
            logoLabel.topAnchor.constraint(equalTo: topAnchor),
            logoLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            logoLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

