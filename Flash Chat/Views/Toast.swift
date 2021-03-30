import UIKit
import SwiftMessages

class Toast: NSObject {
    static let shared = Toast()
    var view: MessageView!
    var config = SwiftMessages.Config()
    override init() {
        super.init()
        // setup view
        view = MessageView.viewFromNib(layout: .cardView)
        view.configureDropShadow()
        view.button?.isHidden = true
        view.titleLabel?.isHidden = true
        view.iconImageView?.isHidden = true
        view.layoutMarginAdditions = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        (view.backgroundView as? CornerRoundingView)?.cornerRadius = 10
        
        // configure
        config.presentationStyle = .bottom
        config.presentationContext = .automatic
        config.duration = .automatic
        config.dimMode = .gray(interactive: true)
        config.interactiveHide = false
        config.preferredStatusBarStyle = .lightContent
    }

    @discardableResult
    convenience init(_ message: String, type: Theme) {
        self.init()
        // set up message and type
        view.configureTheme(type)
        view.configureContent(body: message)
        SwiftMessages.show(config: config, view: view)
    }
}


class WarningToast: Toast {

    @discardableResult
    convenience init(_ message:String) {
        self.init(message,type: .warning)
    }
}
class ErrorToast: Toast {

    @discardableResult
    convenience init(_ message:String) {
        self.init(message,type: .error)
    }
}
class SuccessToast: Toast {

    @discardableResult
    convenience init(_ message:String) {
        self.init(message,type: .success)
    }
}
