//
//  CreateAccountVC.swift
//  smack
//
//  Created by Paul Jablonski on 26/09/2018.
//  Copyright © 2018 Oxido. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        


    }
    
    @IBAction func closePressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    
}
