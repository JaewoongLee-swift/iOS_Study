//
//  RepositoryListViewController.swift
//  GithubRepository
//
//  Created by 이재웅 on 2022/01/07.
//

import UIKit

class RepositoryListViewController: UITableViewController {
    private let organization = "Apple"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = organization + "Repositories"
        
        self.refreshControl = UIRefreshControl()
        let refreshControl = self.refreshControl
        refreshControl?.backgroundColor = .white
        refreshControl?.tintColor = .darkGray
        // refreshControl 하단에 나타나는 설명문구
        refreshControl?.attributedTitle = NSAttributedString(string: "당겨서 새로고침")
        refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        tableView.register(RepositoryListCell.self, forCellReuseIdentifier: "RepositoryListCell")
        tableView.rowHeight = 140
    }
    
    @objc func refresh() {
        
    }
}

//UITableView DataSource Delegate
extension RepositoryListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryListCell", for: indexPath) as? RepositoryListCell else { return UITableViewCell() }
            
            return cell
    }
}
