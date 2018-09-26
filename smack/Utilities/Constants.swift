//
//  Constants.swift
//  smack
//
//  Created by Paul Jablonski on 26/09/2018.
//  Copyright © 2018 Oxido. All rights reserved.
//

import Foundation

typealias CompletionHandler = (_ Success: Bool) -> ()

// Segues

let TO_LOGIN = "toLogin"
let TO_CREATE_ACCOUNT = "toCreateAccount"
let UNWIND = "unwindToChannel"


// User Defaults

let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"



// URL Constants

let BASE_URL = "https://slackclonejablonski.herokuapp.com/v1/"

let URL_REGISTER = "\(BASE_URL)account/register"
