//
//  ChatVC.swift
//  smack
//
//  Created by Paul Jablonski on 25/09/2018.
//  Copyright © 2018 Oxido. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {
    
    // Outlets
    
    @IBOutlet weak var menuBtn: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
    }
    
}
