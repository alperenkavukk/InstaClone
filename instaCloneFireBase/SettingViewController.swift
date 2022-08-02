//
//  SettingViewController.swift
//  instaCloneFireBase
//
//  Created by Alperen Kavuk on 30.07.2022.
//

import UIKit

class SettingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

   
    @IBAction func logoutClicked(_ sender: Any) {
        performSegue(withIdentifier: "toviewController", sender: nil)
    }
    
}
