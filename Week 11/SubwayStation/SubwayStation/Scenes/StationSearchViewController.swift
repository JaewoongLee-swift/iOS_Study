//
//  StationSearchViewController.swift
//  SubwayStation
//
//  Created by 이재웅 on 2021/11/12.
//

import Alamofire
import UIKit
import SnapKit

class StationSearchViewController: UIViewController {
    // 테이블뷰와 서치바는 서로 나타날 때 셀의 개수를 초기화 해줘야 정상적으로 나타나는 관계가 있음. 따라서 일반적으로 개수를 지정해 놓을 경우 서치바가 나타나지 않음. 따라서 임의로 numberOfCell을 통해 첫 화면엔 셀의 개수 0, 검색이 시작될 땐 셀이 나타나도록 설정
//    private var numberOfCell: Int = 0
    private var stations: [Station] = []
    
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

    private func requestStationName(from stationName: String) {
        // json으로 받음
        let urlString = "http://openAPI.seoul.go.kr:8088/sample/json/SearchInfoBySubwayNameService/1/5/\(stationName)"
        
        // .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "" : urlString 주소의 한글은 url을 요청할 때 깨져서 들어가게 됨. 따라서 그것을 방지하기 위한 메소드
        AF
            .request(urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
            .responseDecodable(of: StationResponseModel.self) { [weak self] response in
                // response.result는 성공/실패를 모두 불러오기 때문에 guard문을 통해 우리에게 필요한 성공했을 때의 결과값만을 불러오도록 함
                guard
                    let self = self,
                    case .success(let data) = response.result
                else { return }
                
                self.stations = data.stations
                self.tableView.reloadData()
            }
            .resume()
    }

}

// Cell에서 didSelected 메소드와 같이 대부분의 객체들은 Delegate와 메소드를 가지고 있음.
extension StationSearchViewController: UISearchBarDelegate {
    // 테이블뷰가 나타날 시기 : 서치바에 입력이 된 후, 검색결과가 나타날 시기 : 입력이 완료된 후
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        // 셀의 개수가 초기화 됬으므로 테이블뷰를 다시 리로드해줘야 나타남.
        tableView.reloadData()
        tableView.isHidden = false
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        tableView.isHidden = true
        stations = []
    }
    
    // 유저가 서치바에 입력한게 바뀔 경우 행동하는 메소드
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        requestStationName(from: searchText)
    }
}

extension StationSearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        let station = stations[indexPath.row]
        cell.textLabel?.text = station.stationName
        // detailTextLabel은 cell의 스타일이 subtitle이기 때문에 사용 가능
        cell.detailTextLabel?.text = station.lineNumber
        
        return cell
    }
}

extension StationSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let station = stations[indexPath.row]
        let viewcontroller = StationDetailViewController(station: station)
        navigationController?.pushViewController(viewcontroller, animated: true)
    }
}
