//
//  FeedViewController.swift
//  InstagrClone
//
//  Created by Test on 29.01.24.
//

import UIKit
import Firebase

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var userEmailArray = [String]()
    var commentArray = [String]()
    var likeArray = [Int]()
    var userImageArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getDataFromFirestore()
    }
    
    func getDataFromFirestore() {
        let fireStoreDatabase = Firestore.firestore()
        
        fireStoreDatabase.collection("Posts").addSnapshotListener { snapshot, error in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                if snapshot!.isEmpty != true && snapshot != nil {
                    for document in snapshot!.documents {
                        let documentID = document.documentID
                        
                        if let postedBy = document.get("postedBy") as? String {
                            self.userEmailArray.append(postedBy)
                        }
                        if let postComent = document.get("postComent") as? String {
                            self.commentArray.append(postComent)
                        }
                        if let likes = document.get("likes") as? Int {
                            self.likeArray.append(likes)
                        }
                        if let imageURL = document.get("imageURL") as? String {
                            self.userImageArray.append(imageURL)
                        }
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userEmailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FeedCell
        cell.commentText.text = commentArray[indexPath.row]
        cell.likeCountLabel.text = String(likeArray[indexPath.row])
        cell.userEmailLabel.text = userEmailArray[indexPath.row]
        cell.userImageView.image = UIImage(named: "upload.png")
        return cell
    }

}
