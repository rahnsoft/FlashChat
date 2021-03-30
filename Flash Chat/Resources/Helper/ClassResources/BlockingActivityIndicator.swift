//
//  BlockingActivityIndicator.swift
//  Flash Chat
//
//  Created by IOS DEV PRO 1 on 17/03/2021.
//

import Foundation
import NVActivityIndicatorView

@available(iOS 11.0, *)
final class BlockingActivityIndicator: UIView {
    let activityIndicator: NVActivityIndicatorView

    override init(frame: CGRect) {
        let blockerSize = NVActivityIndicatorView.DEFAULT_BLOCKER_SIZE
        let rect = CGRect(origin: CGPoint(x: UIScreen.main.bounds.midX - (blockerSize.width / 2), y: UIScreen.main.bounds.midY - (blockerSize.height / 2)),
                          size: NVActivityIndicatorView.DEFAULT_BLOCKER_SIZE)
        let iv = NVActivityIndicatorView(frame: rect, type: .ballClipRotatePulse, color:  UIColor(named: Constants.BrandColors.blue), padding: .zero)
        self.activityIndicator = iv
        activityIndicator.startAnimating()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        super.init(frame: frame)
        backgroundColor = UIColor.textColor.withAlphaComponent(0.5)
        addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: layoutMarginsGuide.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: layoutMarginsGuide.centerYAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

@available(iOS 11.0, *)
extension UIWindow {
    func startBlockingActivityIndicator() {
        guard !subviews.contains(where: { $0 is BlockingActivityIndicator }) else {
            return
        }

        let activityIndicator = BlockingActivityIndicator()
        activityIndicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        activityIndicator.frame = bounds

        UIView.transition(
            with: self,
            duration: 0.3,
            options: .transitionCrossDissolve,
            animations: {
                self.addSubview(activityIndicator)
            }
        )
    }

    func stopBlockingActivityIndicator() {
        if let blocker = subviews.first(where: { $0 is BlockingActivityIndicator }) as? BlockingActivityIndicator {
            blocker.activityIndicator.stopAnimating()
            blocker.removeFromSuperview()
        }
    }
}
