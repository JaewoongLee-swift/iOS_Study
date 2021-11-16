//
//  StationSearchViewController.swift
//  SubwayStation
//
//  Created by 이재웅 on 2021/11/12.
//

import UIKit
import SnapKit

class StationSearchViewController: UIViewController {
    // 테이블뷰와 서치바는 서로 나타날 때 셀의 개수를 초기화 해줘야 정상적으로 나타나는 관계가 있음. 따라서 일반적으로 개수를 지정해 놓을 경우 서치바가 나타나지 않음. 따라서 임의로 numberOfCell을 통해 첫 화면엔 셀의 개수 0, 검색이 시작될 땐 셀이 나타나도록 설정
    private var numberOfCell: Int = 0
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isHidden = true
        
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationItems()
        setTableViewLayout()
    }
    
    private func setNavigationItems() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "지하철 도착 정보"
        
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "지하철 역을 입력해주세요."
        // false인 이유 : searchBar를 터치했을 때 하단의 색상을 결정하는 요소. true일 경우 회색으로 변하는데, 이후에 tableview를 넣었을 때도 회색으로 나타나기 때문에 false로 배경색상을 유지시켜줌.
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        
        navigationItem.searchController = searchController
    }
    
    private func setTableViewLayout() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }


}

// Cell에서 didSelected 메소드와 같이 대부분의 객체들은 Delegate와 메소드를 가지고 있음.
extension StationSearchViewController: UISearchBarDelegate {
    // 테이블뷰가 나타날 시기 : 서치바에 입력이 된 후, 검색결과가 나타날 시기 : 입력이 완료된 후
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        numberOfCell = 10
        // 셀의 개수가 초기화 됬으므로 테이블뷰를 다시 리로드해줘야 나타남.
        tableView.reloadData()
        tableView.isHidden = false
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        numberOfCell = 0
        tableView.isHidden = true
    }
}

extension StationSearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfCell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "\(indexPath.row)"
        
        return cell
    }
}

extension StationSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewcontroller = StationDetailViewController()
        navigationController?.pushViewController(viewcontroller, animated: true)
    }
}
