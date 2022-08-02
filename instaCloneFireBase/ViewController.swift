//
//  ViewController.swift
//  instaCloneFireBase
//
//  Created by Alperen Kavuk on 29.07.2022.
//

import UIKit
import Firebase
class ViewController: UIViewController {

    @IBOutlet weak var eMailtxt: UITextField!
    @IBOutlet weak var paswordtxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func signInClicked(_ sender: Any) {
        
        if eMailtxt.text != "" && paswordtxt.text != ""{
        Auth.auth().signIn(withEmail: eMailtxt.text!, password: paswordtxt.text!){ authdata , eror in
        if eror != nil{
            self.makealert(titleinput: "Eror!", messageinput:eror!.localizedDescription)
}       else
            {
                self.performSegue(withIdentifier: "ToFeddVc", sender: nil)
            }
            }
            }
        else
        {
            self.makealert(titleinput: "Eror!", messageinput: "Username/password")
        }
    }
    @IBAction func signUpClicked(_ sender: Any) {
        
        if eMailtxt.text != "" && paswordtxt.text != "" {
            Auth.auth().createUser(withEmail: eMailtxt.text!, password: paswordtxt.text!) {authdata,  eror in
        if eror != nil {
            self.makealert(titleinput: "Eror!", messageinput: eror!.localizedDescription)
                }
        else
        {
            self.performSegue(withIdentifier: "ToFeddVc", sender: nil)
        }
        }
        }
        else
        {
        makealert(titleinput: "Eror", messageinput: "username pasword")
        }
}
    func makealert(titleinput: String, messageinput: String){
        let alert = UIAlertController(title: titleinput, message: messageinput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true)    }
}
