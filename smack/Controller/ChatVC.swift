//
//  ChatVC.swift
//  smack
//
//  Created by Paul Jablonski on 25/09/2018.
//  Copyright © 2018 Oxido. All rights reserved.
//

import UIKit

class ChatVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    


    
    // Outlets
    
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var channelNameLabel: UILabel!
    @IBOutlet weak var messageTextBox: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sendButton: UIButton!
    
    var isTyping = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.bindToKeyboard()
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension
        
        sendButton.isHidden = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ChatVC.handleTap))
        view.addGestureRecognizer(tap)
        
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.channelWasSelected(_:)), name: NOTIF_CHANNEL_SELECTED, object: nil)
        
        SocketService.instance.getMessage { (success) in
            if success {
                self.tableView.reloadData()
                if MessageService.instance.messages.count > 0 {
                    let endIndex = IndexPath(row: MessageService.instance.messages.count - 1, section: 0)
                    self.tableView.scrollToRow(at: endIndex, at: .bottom, animated: false
                    )
                }
            }
        }
        
        if AuthService.instance.isLoggedIn {
            AuthService.instance.findUserByEmail { (success) in
                NotificationCenter.default.post(name:NOTIF_USER_DATA_DID_CHANGE, object: nil)
            }
        }

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as? MessageCell {
            let message = MessageService.instance.messages[indexPath.row]
            cell.configureCell(message: message)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.messages.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    @objc func handleTap(){
        view.endEditing(true)
    }
    
    @objc func userDataDidChange(_ notif: Notification){
        if AuthService.instance.isLoggedIn {
            onLoginGetMessages()
        } else {
            channelNameLabel.text = "Please Log In"
            tableView.reloadData()
        }
    }
    
    func onLoginGetMessages(){
        MessageService.instance.findAllChannels { (success) in
            if success {
                if MessageService.instance.channels.count > 0 {
                    MessageService.instance.selectedChannel = MessageService.instance.channels[0]
                    self.updateWithChannel()
                } else {
                    self.channelNameLabel.text = "No Channels Yet"
                }
            }
        }
    }
    
    func getMessages(){
        guard let channelId = MessageService.instance.selectedChannel?._id else { return }
        MessageService.instance.findAllMessagesForChannel(channelId: channelId) { (success) in
            if success {
                self.tableView.reloadData()
            }
        }
    }
    
    @objc func channelWasSelected(_ notif: Notification){
        updateWithChannel()
    }
    
    func updateWithChannel() {
        let selectedChannel = MessageService.instance.selectedChannel?.name ?? ""
        channelNameLabel.text = "#\(selectedChannel)"
        getMessages()
    }
    
    @IBAction func messageBoxEditing(_ sender: Any) {
        if messageTextBox.text == "" {
            isTyping = false
            sendButton.isHidden = true
        } else {
            if isTyping == false {
                sendButton.isHidden = false
            }
            isTyping = true
        }
    }
    
    @IBAction func sendMessagePressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
            guard let channelId = MessageService.instance.selectedChannel?._id else { return }
            guard let message = messageTextBox.text else { return }
            SocketService.instance.addMessage(messageBody: message, userId: UserDataService.instance.id, channelId: channelId) { (success) in
                if success {
                    self.messageTextBox.text = ""
                    self.messageTextBox.resignFirstResponder()
                }
            }
        }
        
    }
    
    
    
    
    
    
    
    
    
}
