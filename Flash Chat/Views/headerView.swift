////
////  headerView.swift
////  Flash Chat
////
////  Created by IOS DEV PRO 1 on 11/04/2021.
////
//
//import Foundation
//import UIKit
//
//class headerView: UIView {
//    lazy var avatarImage: UIImageView = {
//        let i = UIImageView()
//        i.image = #imageLiteral(resourceName: "MeAvatar")
//        i.translatesAutoresizingMaskIntoConstraints = false
//        return i
//    }()
//        
//    lazy var contentView: UIView = {
//        let v = UIView()
//        v.backgroundColor = .red
//        v.translatesAutoresizingMaskIntoConstraints = false
//        return v
//    }()
//    lazy var senderLabel: UILabel = {
//        let l = UILabel()
//        l.text = "Nick@Gmail.com"
//        l.textColor = .black
//        l.translatesAutoresizingMaskIntoConstraints = false
//       return l
//    }()
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupViews()
//    }
//
//    func setupViews() {
//        addSubview(contentView)
//        contentView.addSubview(avatarImage)
//        contentView.addSubview(senderLabel)
//
//        contentView.topAnchor.constraint(equalTo: topAnchor).isActive = true
//        contentView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
//        contentView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive  = true
//        contentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
//        
//        avatarImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
//        avatarImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
//        avatarImage.widthAnchor.constraint(equalToConstant: 40).isActive = true
//        avatarImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
//        avatarImage.bottomAnchor.constraint(equalTo: senderLabel.topAnchor, constant: -8).isActive = true
//        
//        senderLabel.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant:  8).isActive = true
//        senderLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
//        senderLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
//    }
//
//    @available(*, unavailable)
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
