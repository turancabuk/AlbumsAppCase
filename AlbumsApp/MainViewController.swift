//
//  MainViewController.swift
//  AlbumsApp
//
//  Created by Turan Çabuk on 6.01.2023.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var mainTableView: UITableView!
    
    var viewModel: AlbumsMainViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
       
        viewModel = AlbumsMainViewModel(webservice: AlbumsWebservice())

        mainTableView.delegate = self
        mainTableView.dataSource = self
        
    }
}
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel?.albumsArray.count ?? 0

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "albumCellIdentifier") as! MainTableViewCell
        cell.albumTitleLabel.text = viewModel?.albumsArray.first?.title
        return cell
    }
    
    
}

