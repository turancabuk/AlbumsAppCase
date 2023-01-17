//
//  MainTableViewCell.swift
//  AlbumsApp
//
//  Created by Turan Çabuk on 6.01.2023.
//

import UIKit
import Kingfisher

class MainTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var userIDLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var commentNameLabel: UILabel!
    @IBOutlet weak var commentMailLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var albumCollectionView: UICollectionView!
    
    var viewModel: AlbumsMainViewModel?
    var currentAlbum: UniqueElement?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        albumCollectionView.delegate = self
        albumCollectionView.dataSource = self
        viewModel = AlbumsMainViewModel(webservice: AlbumsWebservice())
        albumCollectionView.backgroundColor = .black
        fetchList()
        
    }
    func configCell (model: UniqueElement) {
        currentAlbum = model
        userIDLabel.text = "user: \(model.album.userID)"
        titleLabel.text = model.album.title
        albumCollectionView.reloadData()
        
    }
    
    private func fetchList() {
        
        guard let viewModel = viewModel else {return}
        viewModel.fetchData(completion: { result in
            DispatchQueue.main.async {
                self.albumCollectionView.reloadData()
            }
        })
    }
}
extension MainTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentAlbum!.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = albumCollectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewIdentifier", for: indexPath) as! AlbumsCollectionViewCell
        let photo = currentAlbum?.photos[indexPath.item]
        cell.configCollectionViewCell(model: photo!)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 140)
        
    }
}
