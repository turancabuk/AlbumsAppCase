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
    var menuView = UIView(frame: CGRect(x: 0, y: 100, width: 250, height: 718))
    let aboutMeButton = UIButton(frame: CGRect(x: 50, y: 650, width: 150, height: 40))
    
    
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
        loadMenuView()
        aboutMeButtonClicked()
  
    }
    @IBAction func menuButtonClicked(_ sender: Any) {
        if menuView.isHidden {
            menuView.isHidden = false
        } else {
            menuView.isHidden = true
        }
    }
    
}
