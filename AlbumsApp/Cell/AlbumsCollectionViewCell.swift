//
//  AlbumsCollectionViewCell.swift
//  AlbumsApp
//
//  Created by Turan Çabuk on 13.01.2023.
//

import UIKit
import Kingfisher

class AlbumsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var collectionImageView: UIImageView!
    
    var viewModel: AlbumsMainViewModel?
    
    
    
    func configCollectionViewCell(model: PhotoElement){
        collectionImageView.contentMode = .scaleToFill
        
        if let urlString = model.url, let url = URL(string: urlString) {
            self.collectionImageView.kf.setImage(with: url)
    }
  }
}
