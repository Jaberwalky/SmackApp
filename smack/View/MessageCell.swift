//
//  MessageCell.swift
//  smack
//
//  Created by Paul Jablonski on 02/10/2018.
//  Copyright © 2018 Oxido. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var userImg: CircleImage!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var timeStampLable: UILabel!
    @IBOutlet weak var messageBodyLabel: UILabel!

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(message: Message){
        messageBodyLabel.text = message.message
        userImg.image = UIImage(named: message.userAvatar)
        userImg.backgroundColor = UserDataService.instance.returnUIColor(components: message.userAvatarColor)
        
    }
}
