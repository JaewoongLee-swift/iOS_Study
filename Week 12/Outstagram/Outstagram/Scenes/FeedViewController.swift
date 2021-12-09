//
//  FeedViewController.swift
//  Outstagram
//
//  Created by 이재웅 on 2021/12/09.
//

import UIKit
import SnapKit

class FeedViewController: UIViewController {
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.backgroundColor = .systemBackground
        // separator를 안보이게 하기 위함
        tableView.separatorStyle = .none
        tableView.dataSource = self
        
        tableView.register(FeedTableViewCell.self, forCellReuseIdentifier: "FeedTableViewCell")
        
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupTableView()
    }
}
extension FeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedTableViewCell", for: indexPath) as? FeedTableViewCell
        cell?.selectionStyle = .none
        cell?.setup()
        
        return cell ?? UITableViewCell()
    }
}

private extension FeedViewController {
    func setupNavigationBar() {
        navigationItem.title = "Outstagram"
        
        let uploadButton = UIBarButtonItem(
            image: UIImage(systemName: "plus.app"),
            style: .plain,
            target: self,
            action: nil
        )
        navigationItem.rightBarButtonItem = uploadButton
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints{ $0.edges.equalToSuperview() }
    }
}

