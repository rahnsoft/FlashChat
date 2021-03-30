//
//  File.swift
//  Flash Chat
//
//  Created by IOS DEV PRO 1 on 22/03/2021.
//

import Foundation
import UIKit

class TimeIndicatorView: UITableViewHeaderFooterView {
    lazy var containerView: UIView = {
        let c = UIView()
        c.layer.cornerRadius = 6
        c.translatesAutoresizingMaskIntoConstraints = false
        return c
    }()

    lazy var timeLabel: UILabel = {
        let l = UILabel()
        l.textColor = .black
        l.layer.cornerRadius = 6
        l.clipsToBounds = true
        l.contentMode = .scaleAspectFit
        l.font = UIFont.boldSystemFont(ofSize: Constants.DEFAULT_PADDING + 6)
        l.backgroundColor = UIColor(named: Constants.BrandColors.lightBlue)
        l.textAlignment = .center
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        constraintsAll()
    }

    func constraintsAll() {
        backgroundView = UIView()
        backgroundView?.backgroundColor = .clear
        contentView.backgroundColor = .clear
        contentView.addSubview(containerView)
        containerView.addSubview(timeLabel)
        containerView.backgroundColor = UIColor(named: Constants.BrandColors.lightBlue)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.DEFAULT_PADDING),
            containerView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.DEFAULT_PADDING),

            timeLabel.topAnchor.constraint(equalTo: containerView.layoutMarginsGuide.topAnchor),
            timeLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Constants.DEFAULT_PADDING),
            timeLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Constants.DEFAULT_PADDING),
            timeLabel.bottomAnchor.constraint(equalTo: containerView.layoutMarginsGuide.bottomAnchor)
        ])
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
