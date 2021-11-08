//
//  CalenderViewController.swift
//  Calender
//
//  Created by 이재웅 on 2021/11/05.
//

import UIKit
import SnapKit

class CalenderViewController: UIViewController {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.backgroundColor = .systemBackground
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(CalenderCollectionCell.self, forCellWithReuseIdentifier: "CalenderCollectionCell")
        collectionView.register(CalenderCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CalenderCollectionHeaderView")
        
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

extension CalenderViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let myBoundSize: CGFloat = UIScreen.main.bounds.size.width
        let cellSize: CGFloat = myBoundSize / 9
        return CGSize(width: cellSize, height: cellSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: collectionView.frame.width, height: 40.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let value: CGFloat = 8.0
        return UIEdgeInsets(top: value, left: value, bottom: value, right: value)
    }
}

extension CalenderViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        switch section {
//        case 0:
//            return 7 // 월 화 수 목 금 토 일
//        default:
//            return ?? // 월 별 일 수
//        }
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalenderCollectionCell", for: indexPath) as? CalenderCollectionCell
        
        cell?.setupSubViews()
        
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader,
              let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "CalenderCollectionHeaderView",
                for: indexPath
              ) as? CalenderCollectionHeaderView
        else { return UICollectionReusableView() }
        
        header.setupViews()
        
        return header
    }
    
}
