//
//  SubwayInformationViewController.swift
//  SubwayStation
//
//  Created by 이재웅 on 2021/11/16.
//

import Alamofire
import SnapKit
import UIKit

final class StationDetailViewController: UIViewController {
    private let station: Station
    private var realtimeArrivalList: [StationArrivalDatResponseModel.RealTimeArrival] = []
    
    private lazy var refreshControl: UIRefreshControl = {
       let refreshControl = UIRefreshControl()
        // valueChanged : refreshControl이 켜진 후 값이 변하면 해당 메소드를 실행한다는 의미
        refreshControl.addTarget(self, action: #selector(fetchData), for: .valueChanged)
        
        return refreshControl
    }()
    
    private lazy var collectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        // cell의 최소사이즈
        layout.estimatedItemSize = CGSize(
            width: view.frame.width - 32.0,
            height: 100.0
        )
        // navigationbar와 같은 다른 섹션과의 마진
        layout.sectionInset = UIEdgeInsets(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0)
        // 상하스크롤 구현
        layout.scrollDirection = .vertical
        
       let collectionView = UICollectionView(frame: .zero,collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(
            StationDetailCollectionViewCell.self,
            forCellWithReuseIdentifier: "StationDetailCollectionViewCell"
        )
        
        collectionView.dataSource = self
        // refreshControl은 collectionview의 기본변수이다. 하지만 옵셔널이기 때문에 값을 지정해서 넣어주고 사용하면 됨.
        collectionView.refreshControl = refreshControl
        return collectionView
    }()
    
    init(station: Station) {
        self.station = station
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = station.stationName
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        fetchData()
    }
    
    @objc private func fetchData() {
        // refreshControl 종료
//        refreshControl.endRefreshing()
        
        // api 주소가 '~~역'으로 이루어져 있고 '서울' 또는 '왕십리' 같이 지명으로만 이루어져 있음. 따라서 '서울역'으로 지하철역의 이름을 통째로 받되 '역'을 지우는 메소드를 사용 (replacingOccurrences)
        let stationName = station.stationName
        let urlString = "http://swopenapi.seoul.go.kr/api/subway/sample/json/realtimeStationArrival/0/5/\(stationName.replacingOccurrences(of: "역", with: ""))"
        AF
            .request(urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
            .responseDecodable(of: StationArrivalDatResponseModel.self) { [weak self] response in
                // refreshControl이 멈춰야 할 타이밍은 서버의 request가 완료되고 뷰를 그려야할 시점. guard문 아래에 endRefreshing()을 사용하면 request가 성공했을 시에만 refreshControl가 멈추기 때문에 그 전에 decoding을 일단 요청할 때 멈춰야 함.
                self?.refreshControl.endRefreshing()
                guard case .success(let data) = response.result else { return }
                
                self?.realtimeArrivalList = data.realtimeArrivalList
                self?.collectionView.reloadData()
                
            }
            .resume()
    }
}

extension StationDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return realtimeArrivalList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "StationDetailCollectionViewCell",
            for: indexPath
        ) as? StationDetailCollectionViewCell
        
        let realTimeArrival = realtimeArrivalList[indexPath.row]
        cell?.setup(with: realTimeArrival)
        return cell ?? UICollectionViewCell()
    }
}
