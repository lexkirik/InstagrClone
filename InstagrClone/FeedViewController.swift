//
//  FeedViewController.swift
//  InstagrClone
//
//  Created by Test on 29.01.24.
//

import UIKit

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FeedCell
        cell.commentText.text = "comment"
        cell.likeCountLabel.text = "0"
        cell.userEmailLabel.text = "user@mail.com"
        cell.userImageView.image = UIImage(named: "upload.png")
        return cell
    }

}
