//
//  TodayViewController.swift
//  AppStore
//
//  Created by 이재웅 on 2021/10/22.
//

import UIKit
import SnapKit

// TodayViewController를 상속할 class는 없기 때문에 final로 선언
final class TodayViewController: UIViewController {
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.backgroundColor = .systemBackground
        collectionView.register(TodayCollectionViewCell.self, forCellWithReuseIdentifier: "todayCell")
        // Header와 Footer는 forSupplementaryViewOfKind가 있는 register를 사용해야함
        collectionView.register(TodayCollectionHeaderView.self,
                                // string값을 직접 써도 되고 다음과 같이 UICollectionView.elementKindSectionHeader로 작성해도 됨
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: "TodayCollectionHeaderView")
    
            return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }
    
}

extension TodayViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "todayCell", for: indexPath) as? TodayCollectionViewCell else { return UICollectionViewCell() }
        cell.setup()
        
        return cell
    }
    
    // Header와 Footer를 리턴해주는 메소드(viewForSupplementaryElementOfKind 검색)
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // Header와 Footer 모두 동일한 메소드를 요청하기 때문에 구분해주는 것이 필요함
        guard kind == UICollectionView.elementKindSectionHeader,
              let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "TodayCollectionHeaderView",
                for: indexPath
              ) as? TodayCollectionHeaderView
        else { return UICollectionReusableView() }
        
        header.setupViews()
        
        return header
    }
}

extension TodayViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - 32.0
        
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: collectionView.frame.width - 32.0, height: 100.0)
    }
    
    // Header와 CollectionView 사이의 inset을 위한 메소드(insetForSectionAt 검색)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let value: CGFloat = 16.0
        return UIEdgeInsets(top: value, left: value, bottom: value, right: value)
    }
}
