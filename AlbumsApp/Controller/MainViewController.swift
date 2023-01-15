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
        fetchData()
        
    }
    func fetchData() {
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
        
        return groupedUniqueElements.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "albumCellIdentifier", for: indexPath) as! MainTableViewCell
        let elements = groupedUniqueElements[groupedUniqueElements.keys.sorted()[indexPath.row]]
        let currentAlbum = (elements?.first)!
        cell.configCell(model: currentAlbum)
        return cell
        
    }
}
extension MainViewController {
    var groupedUniqueElements: [Int: [UniqueElement]] {
        var groupedElements: [Int: [UniqueElement]] = [:]
        for element in viewModel.uniqueElement {
            if groupedElements[element.album.id] == nil {
                groupedElements[element.album.id] = [element]
            } else {
                groupedElements[element.album.id]?.append(element)
            }
        }
        return groupedElements
    }
}
