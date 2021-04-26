//
//  SenderCell.swift
//  Flash Chat
//
//  Created by IOS DEV PRO 1 on 08/04/2021.
//


import UIKit

class SenderCell: UITableViewCell {
    lazy var messageView: UIView = {
        let v = UIView()
        v.layer.cornerRadius = 15
        v.backgroundColor = UIColor(named: Constants.BrandColors.lightBlue)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var label: SubClassUILabel = {
        let l = SubClassUILabel()
        l.textColor = .black
        l.contentMode = .scaleAspectFit
        l.textAlignment = .justified
        l.isUserInteractionEnabled = true
        l.setContentHuggingPriority(.required, for: .horizontal)
        l.setContentHuggingPriority(.required, for: .vertical)
        l.font = UIFont.systemFont(ofSize: Constants.DEFAULT_PADDING + 6 )
        l.numberOfLines = .zero
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    lazy var avatarImage: UIImageView = {
        let i = UIImageView()
        i.image = #imageLiteral(resourceName: "YouAvatar")
        i.translatesAutoresizingMaskIntoConstraints = false
        return i
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        constraintsAll()
    }

    func constraintsAll() {
        contentView.backgroundColor = .white
        contentView.addSubview(avatarImage)
        contentView.addSubview(messageView)
        messageView.addSubview(label)
        NSLayoutConstraint.activate([
            messageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.DEFAULT_PADDING),
            messageView.trailingAnchor.constraint(equalTo: label.trailingAnchor, constant: Constants.DOUBLE_PADDING),
            messageView.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: -Constants.DEFAULT_PADDING),
            messageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.DEFAULT_PADDING),
            
            label.topAnchor.constraint(equalTo: messageView.topAnchor, constant: Constants.DEFAULT_PADDING),
            label.widthAnchor.constraint(lessThanOrEqualToConstant: UIScreen.main.bounds.size.width / 1.5),
            label.leadingAnchor.constraint(equalTo: messageView.leadingAnchor, constant: Constants.DOUBLE_PADDING),
            label.bottomAnchor.constraint(equalTo: messageView.bottomAnchor, constant: -Constants.DEFAULT_PADDING),
            
            avatarImage.topAnchor.constraint(equalTo: messageView.topAnchor),
            avatarImage.widthAnchor.constraint(equalToConstant: 30),
            avatarImage.heightAnchor.constraint(equalToConstant: 30),
            avatarImage.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor, constant: Constants.DEFAULT_PADDING),
            avatarImage.trailingAnchor.constraint(equalTo: messageView.leadingAnchor, constant: -Constants.DEFAULT_PADDING)
        ]
        )
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
