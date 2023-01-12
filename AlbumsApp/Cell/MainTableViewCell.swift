//
//  MainTableViewCell.swift
//  AlbumsApp
//
//  Created by Turan Çabuk on 6.01.2023.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var userIDLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var commentNameLabel: UILabel!
    @IBOutlet weak var commentMailLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var albumImage: UIImageView!
    
    
    func configCell (model: UniqueElement) {
        userIDLabel.text = "user: \(model.album.userID!)"
        titleLabel.text = model.album.title
        commentNameLabel.text = model.comment.name
        commentMailLabel.text = model.comment.email
        commentLabel.text = model.comment.body
        
        if let urlString = model.photo.thumbnailURL, let url = URL(string: urlString) {
            albumImage.kf.setImage(with: url)

        }
    }
    
}
