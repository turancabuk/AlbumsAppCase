//
//  MainViewController.swift
//  AlbumsApp
//
//  Created by Turan Çabuk on 6.01.2023.
//

import UIKit
import Kingfisher

class MainViewController: UIViewController {
    
    @IBOutlet weak var mainTableView: UITableView!
    
    let viewModel: AlbumsMainViewModel
    
    init(viewModel: AlbumsMainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.viewModel = AlbumsMainViewModel(webservice: AlbumsWebservice())
        super.init(coder: coder)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
        
        
        viewModel.fetchData { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let items):
                DispatchQueue.main.async {
                    self.viewModel.uniqueElement = items
                    self.mainTableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.uniqueElement.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "albumCellIdentifier") as! MainTableViewCell
        
        let currentAlbum = viewModel.uniqueElement[indexPath.row]
        cell.userIDLabel.text = "user: \(currentAlbum.album.userID!)"
        cell.titleLabel.text = currentAlbum.album.title
        cell.commentNameLabel.text = currentAlbum.comment.name
        cell.commentMailLabel.text = currentAlbum.comment.email
        cell.commentLabel.text = currentAlbum.comment.body
        
        let url = URL(string: currentAlbum.photo.url ?? "")
        cell.albumImage.kf.setImage(with: url)
        
        return cell
    }
}

