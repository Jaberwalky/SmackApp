//
//  UserDataService.swift
//  smack
//
//  Created by Paul Jablonski on 26/09/2018.
//  Copyright © 2018 Oxido. All rights reserved.
//

import Foundation

class UserDataService{
    
    static let instance = UserDataService()
    
    // public for reading but can only be set within this class
    public private(set) var id = ""
    public private(set) var avatarColor = ""
    public private(set) var avatarName = ""
    public private(set) var email = ""
    public private(set) var name = ""
    
    func setUserData(id: String, color: String, avatarName: String, email: String, name: String) {
        print("in set user data")
        
        self.id = id
        self.avatarColor = color
        self.avatarName = avatarName
        self.email = email
        self.name = name
    }
    
    func setAvatarName(avatarName: String){
        self.avatarName = avatarName
    }
}