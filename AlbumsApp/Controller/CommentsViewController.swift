//
//  CommentsViewController.swift
//  AlbumsApp
//
//  Created by Turan Çabuk on 16.01.2023.
//

import UIKit

class CommentsViewController: UIViewController {
   
    
    @IBOutlet weak var commentsTableView: UITableView!
    var comments: [CommentElement] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerTableViewCell()
        commentsTableView.delegate = self
        commentsTableView.dataSource = self
    }
    
    func registerTableViewCell() {
        self.commentsTableView.register(UINib.init(nibName: "CommentsCell", bundle: nil), forCellReuseIdentifier: "CommentsCell")
        self.commentsTableView.estimatedRowHeight = 100
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension CommentsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentsCell", for: indexPath) as! CommentsCell
        let comment = self.comments[indexPath.row]
        cell.comment = comment
        return cell
    }

}

