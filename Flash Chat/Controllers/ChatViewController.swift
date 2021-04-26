//
//  ChatViewController.swift
//  Flash Chat
//
//  Created by IOS DEV PRO 1 on 04/01/2021.
//

import Firebase
import NVActivityIndicatorView
import UIKit

class ChatViewController: UIViewController {
    let db = Firestore.firestore()
    var messages: [Message] = []
    lazy var inputContainerView: ChatView = {
        let c = ChatView()
        c.inputMessage.delegate = self
        c.sendBtn.addTarget(self, action: #selector(sendPressed), for: .touchUpInside)
        c.translatesAutoresizingMaskIntoConstraints = false
        return c
    }()

    lazy var timeIndicatorView: TimeIndicatorView = {
        let t = TimeIndicatorView()
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()

    lazy var tableView: UITableView = {
        let t = UITableView(frame: .zero, style: .plain)
        t.delegate = self
        t.dataSource = self
        t.separatorStyle = .none
        t.estimatedRowHeight = 50
        t.backgroundColor = .clear
        t.isUserInteractionEnabled = true
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()

    override var canBecomeFirstResponder: Bool { return true }
    private var _inputAccessoryView: UIView!
    override var inputAccessoryView: UIView? {
        if _inputAccessoryView == nil {
            _inputAccessoryView = InputAccessoryView()
            _inputAccessoryView.backgroundColor = #colorLiteral(red: 0.6971203685, green: 0.3157409728, blue: 0.9535165429, alpha: 1)
            _inputAccessoryView.addSubview(inputContainerView)
            _inputAccessoryView.autoresizingMask = .flexibleHeight
            inputContainerView.translatesAutoresizingMaskIntoConstraints = false
            inputContainerView.leadingAnchor.constraint(equalTo: _inputAccessoryView.leadingAnchor).isActive = true
            inputContainerView.trailingAnchor.constraint(equalTo: _inputAccessoryView.trailingAnchor).isActive = true
            inputContainerView.topAnchor.constraint(equalTo: _inputAccessoryView.topAnchor).isActive = true
            inputContainerView.bottomAnchor.constraint(equalTo: _inputAccessoryView.layoutMarginsGuide.bottomAnchor).isActive = true
        }
        return _inputAccessoryView
    }

    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(inputContainerView)
        setNeedsStatusBarAppearanceUpdate()
        title = "txt_logo_text".localize()
        navigationItem.hidesBackButton = true
        let customView = UIBarButtonItem(title: "txt_log_out".localize(), style: .plain, target: self, action: #selector(logOut))
        navigationItem.rightBarButtonItem = customView
        getMessages()
        messages.indices.contains(1)
        tableView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor).isActive = true
        tableView.register(RecipientCell.self, forCellReuseIdentifier: RecipientCell.identifier)
        tableView.register(SenderCell.self, forCellReuseIdentifier: SenderCell.identifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.identifier)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIApplication.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide(_:)), name: UIApplication.keyboardDidHideNotification, object: nil)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIApplication.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIApplication.keyboardDidHideNotification, object: nil)
    }

    @objc func keyboardWillShow(_ notification: Notification) {
        tableView.contentInset.bottom = notification.getKeyboardHeight + Constants.DOUBLE_PADDING
        DispatchQueue.main.async {
            if !self.messages.isEmpty {
                debugPrint("Scrolling")
                let sectionCount = self.getGrouped()
                let section = sectionCount.count - 1
                self.tableView.scrollToRow(at: IndexPath(row: sectionCount[section].value.count - 1,
                                                         section: section), at: .bottom, animated: false)
            }
        }
    }

    @objc func keyboardDidHide(_ notification: Notification) {
        tableView.contentInset.bottom = notification.getKeyboardHeight
    }

    @objc func logOut() {
        UIApplication.shared.keyWindow?.startBlockingActivityIndicator()
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            ErrorToast(signOutError.localizedDescription)
        }
        UIApplication.shared.keyWindow?.stopBlockingActivityIndicator()
    }
}

extension ChatViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView == inputContainerView.inputMessage {
            textView.text = nil
            textView.textColor = .black
        }
        inputContainerView.sendBtn.isEnabled = textView.text.isEmpty || textView.text == "txt_enter_message".localize() ? false : true
    }

    func textViewDidChange(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "txt_enter_message".localize()
            textView.textColor = .lightGray
            let newPosition = textView.beginningOfDocument
            textView.selectedTextRange = textView.textRange(from: newPosition, to: newPosition)
        }
        inputContainerView.sendBtn.isEnabled = textView.text.isEmpty || textView.text == "txt_enter_message".localize() ? false : true
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if textView.text == "txt_enter_message".localize() {
            textView.text = nil
            textView.textColor = .black
        }
        inputContainerView.sendBtn.isEnabled = textView.text.isEmpty || textView.text == "txt_enter_message".localize() ? false : true
        return true
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        inputContainerView.sendBtn.isEnabled = textView.text.isEmpty || textView.text == "txt_enter_message".localize() ? false : true
    }

    @objc func sendPressed() {
        UIApplication.shared.keyWindow?.startBlockingActivityIndicator()
        let textView = inputContainerView.inputMessage
        if textView.text.isEmpty || textView.text == "txt_enter_message".localize() {
            ErrorToast("Please input Message")
            inputContainerView.sendBtn.isEnabled = false
        } else if let message = inputContainerView.inputMessage.text, let messageSender = Auth.auth().currentUser?.email {
            db.collection(Constants.FStore.collectionName).addDocument(data: [
                Constants.FStore.senderField: messageSender,
                Constants.FStore.bodyField: message,
                Constants.FStore.dateField: Date().timeIntervalSince1970
            ]) { error in
                if let e = error {
                    debugPrint("FireStoreSaving error \(e.localizedDescription)")
                } else {
                    DispatchQueue.main.async {
                        textView.text = nil
                        let newPosition = textView.beginningOfDocument
                        textView.selectedTextRange = textView.textRange(from: newPosition, to: newPosition)
                        let sectionCount = self.getGrouped()
                        let section = sectionCount.count - 1
                        self.tableView.reloadData()
                        self.tableView.scrollToRow(at: IndexPath(row: sectionCount[section].value.count - 1,
                                                                 section: section), at: .bottom, animated: false)
                    }
                    debugPrint("FireStoreSaving succesful")
                }
            }
        }
        UIApplication.shared.keyWindow?.stopBlockingActivityIndicator()
    }

    func getMessages() {
        UIApplication.shared.keyWindow?.startBlockingActivityIndicator()
        db.collection(Constants.FStore.collectionName)
            .order(by: Constants.FStore.dateField, descending: false).addSnapshotListener { querySnapshot, error in
                self.messages = []
                if let e = error {
                    debugPrint(e.localizedDescription)
                } else if let snapShotDocuments = querySnapshot?.documents {
                    for documents in snapShotDocuments {
                        let data = documents.data()
                        let messageSender = data[Constants.FStore.senderField] as? String
                        let messageBody = data[Constants.FStore.bodyField] as? String
                        let date = data[Constants.FStore.dateField] as? TimeInterval
                        let messages = [Message(sender: messageSender, body: messageBody, date: Date(timeIntervalSince1970: date ?? Date().timeIntervalSinceNow))]
                        self.messages.append(contentsOf: messages)
                        debugPrint("messages: \(self.messages), \(self.messages.count)")
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                            self.getGrouped()
                        }
                    }
                }
            }
        UIApplication.shared.keyWindow?.stopBlockingActivityIndicator()
    }

    fileprivate func getGrouped() -> [(key: String, value: [Message])] {
        let groupedMessages = Dictionary(grouping: messages) { (element) -> String in
            element.formattedDate
        }
        let sortedGroupMessages = groupedMessages.sorted(by: { $0.key < $1.key })
        return sortedGroupMessages
    }
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let groupMessages = getGrouped()[section].value.count
        return groupMessages
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: TimeIndicatorView.identifier) as? TimeIndicatorView ?? TimeIndicatorView()
        let groupMessages = getGrouped()
        cell.timeLabel.text = groupMessages[section].key
        return cell
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        let section = getGrouped()
        return section.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        inputContainerView.inputMessage.resignFirstResponder()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let groupMessages = getGrouped()
        let messageBody = groupMessages[indexPath.section].value[indexPath.row]
        let loggedInSender = Auth.auth().currentUser?.email
        if messageBody.sender == loggedInSender {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: RecipientCell.identifier, for: indexPath) as? RecipientCell else { return UITableViewCell() }
            cell.label.text = messageBody.body
            cell.selectionStyle = .none
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SenderCell.identifier, for: indexPath) as? SenderCell else { return UITableViewCell() }
            cell.label.text = messageBody.body
            cell.selectionStyle = .none
            return cell
        }
    }
}
