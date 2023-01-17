//
//  MainExtensions.swift
//  AlbumsApp
//
//  Created by Turan Çabuk on 16.01.2023.
//

import Foundation
import UIKit

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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let commentVC = storyboard.instantiateViewController(withIdentifier: "commentsCellIdentifier") as! CommentsViewController
        let selectedAlbum = self.viewModel.albumList[indexPath.row]
        commentVC.comments = selectedAlbum.commentElement ?? []
        navigationController?.pushViewController(commentVC, animated: true)
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
extension MainViewController {
    func loadMenuView() {
        view.addSubview(menuView)
        menuView.backgroundColor = UIColor.lightGray
        menuView.isHidden = true
        menuView.backgroundColor = UIColor.lightGray
        menuView.isHidden = true
    }
}
extension MainViewController {
    func aboutMeButtonClicked() {
        aboutMeButton.backgroundColor = UIColor.blue
        aboutMeButton.setTitle("About Me", for: .normal)
        aboutMeButton.setTitleColor(UIColor.white, for: .normal)
        aboutMeButton.addTarget(self, action: #selector(goToAboutMePage), for: .touchUpInside)
        menuView.addSubview(aboutMeButton)
        
    }
}
extension MainViewController {
    @objc func goToAboutMePage() {
        guard let url = URL(string: "https://github.com/turancabuk") else { return }
        UIApplication.shared.open(url)
    }
}
extension MainViewController {
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
