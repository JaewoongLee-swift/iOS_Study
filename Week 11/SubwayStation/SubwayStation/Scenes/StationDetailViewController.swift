//
//  SubwayInformationViewController.swift
//  SubwayStation
//
//  Created by 이재웅 on 2021/11/16.
//

import SnapKit
import UIKit

final class StationDetailViewController: UIViewController {
    private lazy var refreshControl: UIRefreshControl = {
       let refreshControl = UIRefreshControl()
        // valueChanged : refreshControl이 켜진 후 값이 변하면 해당 메소드를 실행한다는 의미
        refreshControl.addTarget(self, action: #selector(fetchData), for: .valueChanged)
        
        return refreshControl
    }()
    
    @objc func fetchData() {
        print("REFRESH !")
        // refreshControl 종료
        refreshControl.endRefreshing()
    }
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "왕십리"
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
}

extension StationDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "StationDetailCollectionViewCell",
            for: indexPath
        ) as? StationDetailCollectionViewCell
        
        cell?.setup()
        return cell ?? UICollectionViewCell()
    }
    
    
}
