//
//  UploudViewController.swift
//  instaCloneFireBase
//
//  Created by Alperen Kavuk on 30.07.2022.
//

import UIKit
import Firebase

class UploudViewController: UIViewController , UIImagePickerControllerDelegate ,UINavigationControllerDelegate {
    @IBOutlet weak var commandtext: UITextField!
    @IBOutlet weak var uploudbutton: UIButton!
    @IBOutlet weak var imageview: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageview.isUserInteractionEnabled=true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(choseImage))
        imageview.addGestureRecognizer(gestureRecognizer)
        
    }
    
    @objc func choseImage(){
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true , completion: nil)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        imageview.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true , completion: nil
        )
    }
    func makeAlert(tittlInput: String, MessageInput: String){
        let alert = UIAlertController(title: tittlInput, message: MessageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func uploudbuttonClicked(_ sender: Any) {
        let stroge = Storage.storage()
        let storgeReference = stroge.reference()
        
        let mediaFolder = storgeReference.child("media")
        let uuid = UUID().uuidString
        
        if let data = imageview.image?.jpegData(compressionQuality: 0.5)
        {
            let imageReference = mediaFolder.child("\(uuid).jpg")
            imageReference.putData(data, metadata: nil) { metadata, eror in
            
                if eror != nil {
                    self.makeAlert(tittlInput: "Eror!", MessageInput: eror?.localizedDescription ?? "EROR")
                }
                else
                {
                imageReference.downloadURL { url, eror in
                    if eror == nil{
                        let imageUrl = url?.absoluteString
                            //database
                        let firestoreDatabase = Firestore.firestore()
                        var firestoreReference : DocumentReference? = nil
                        let firestorePost = ["imageUrl": imageUrl!, "posted my" :Auth.auth().currentUser!.email!, "postmooand": self.commandtext!, "date": FieldValue.serverTimestamp(), "likes": 0] as [String : Any ]
                            firestoreReference = firestoreDatabase.collection("posts").addDocument(data:  firestorePost, completion: { eror in
                                if eror != nil{
                                    self.makeAlert(tittlInput: "eror", MessageInput: eror?.localizedDescription ?? "eror")
                                }
                                else
                                {
                                    self.imageview.image = UIImage(named: "selectimage")
                                    self.commandtext.text = ""
                                    self.tabBarController?.selectedIndex = 0
                                }
                            })
                        }
                    }
                }
            }
        }
        
    }
    
}
