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
    var messages: [[Message]] = []
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
        t.dataSource = self
        t.delegate = self
        t.estimatedRowHeight = 50
        t.backgroundColor = .clear
        t.isUserInteractionEnabled = true
        t.separatorStyle = .none
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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(inputContainerView)
        getMessages()
        attempGroupingByDates()
        tableView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor).isActive = true
        tableView.register(MessageCell.self, forCellReuseIdentifier: MessageCell.identifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.identifier)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "txt_logo_text".localize()
        navigationItem.hidesBackButton = true
        let logOutBtn = UIBarButtonItem(title: "txt_log_out".localize(), style: .plain, target: self, action: #selector(logOut))
        navigationItem.leftBarButtonItem = logOutBtn
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: Constants.BrandColors.purple)]
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 1, green: 0.9039199352, blue: 1, alpha: 1)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIApplication.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIApplication.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide(_:)), name: UIApplication.keyboardDidHideNotification, object: nil)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIApplication.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIApplication.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIApplication.keyboardDidHideNotification, object: nil)
    }
    
    fileprivate func attempGroupingByDates(){
        
    }
    @objc func keyboardWillShow(_ notification: Notification) {
        let section = messages.count - 1
        tableView.contentInset.bottom = notification.getKeyboardHeight
        DispatchQueue.main.async {
            if self.messages != nil, !self.messages.isEmpty {
                debugPrint("Scrolling")
                self.tableView.scrollToRow(at: IndexPath(row: self.messages[section].count - 1, section: section), at: .bottom, animated: true)
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

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages[section].count
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: TimeIndicatorView.identifier) as? TimeIndicatorView ?? TimeIndicatorView()
        cell.timeLabel.text = messages[section][0].formattedDate
        return cell
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return messages.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MessageCell.identifier, for: indexPath) as? MessageCell else { return UITableViewCell() }
        cell.label.text = messages[indexPath.section][indexPath.row].body
        cell.selectionStyle = .none
        return cell
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
        let textView = self.inputContainerView.inputMessage
        if textView.text.isEmpty || textView.text == "txt_enter_message".localize() {
            ErrorToast("Please input Message")
            inputContainerView.sendBtn.isEnabled = false
        } else if let message = inputContainerView.inputMessage.text, let messageSender = Auth.auth().currentUser?.email {
            messages = []
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
                        let section = self.messages.count - 1
                        self.tableView.reloadData()
                        self.tableView.scrollToRow(at: IndexPath(row: self.messages[section].count - 1, section: section), at: .bottom, animated: true)
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
            .order(by: Constants.FStore.dateField, descending: false)
            .addSnapshotListener { querySnapshot, error in
            if let e = error {
                debugPrint(e.localizedDescription)
            } else if let snapShotDocuments = querySnapshot?.documents {
                for documents in snapShotDocuments {
                    let data = documents.data()
                    let messageSender = data[Constants.FStore.senderField] as? String
                    let messageBody = data[Constants.FStore.bodyField] as? String
                    let date = data[Constants.FStore.dateField] as? Date
                    let messages = [Message(sender: messageSender, body: messageBody, date: date)]
                    self.messages.append(messages)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }
        UIApplication.shared.keyWindow?.stopBlockingActivityIndicator()
    }
    
}
