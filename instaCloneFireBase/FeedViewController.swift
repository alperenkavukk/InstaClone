//
//  FeedViewController.swift
//  instaCloneFireBase
//
//  Created by Alperen Kavuk on 30.07.2022.
//

import UIKit
import Firebase
class FeedViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var userEmailArray = [String]()
    var commantArray = [String]()
    var likeArray = [Int]()
    var imageArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        getDataFromFirestore()

    }
    func getDataFromFirestore(){
        let fireStoreDatabase = Firestore.firestore()
        
       /*let settings = fireStoreDatabase.settings
        settings.areAnimationsEnabled = true
        fireStoreDatabase.settings = settings
         tarih ile ilgili hata olursa
         */
        fireStoreDatabase.collection("Posts").addSnapshotListener { snapshot, eror in
            if eror != nil {
                //self.makealert(titleinput: "eror", messageinput: "dosya gönderilmedi")
            }
            else{
                if snapshot?.isEmpty != true && snapshot != nil{
                    for document in snapshot!.documents{
                        let documentId = document.documentID
                /*
                 if let postedById = document.get("postedById") as? String {
                 self.userEmailArray.append(postedById)
                 
                 if let postedcommant = document.get("postedcommant") as? String {
                 self.commantArray.append(postedcommant)
                 // tüm arraylere eklenecek
                 if let likes = document.get("likes") as? Int {
                 self.likeArray.append(likes)
                 
                 
                  */  }
                    self.tableView.reloadData()
                }
                
        }
    }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userEmailArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath ) as! TableViewCell
        cell.commantlabel.text = commantArray[indexPath.row]
        cell.likelabel.text = String(likeArray[indexPath.row])
        cell.useremailLabel.text = userEmailArray[indexPath.row]
        cell.imageView?.image = UIImage(named: "selectimage")
        return cell
    }

}
