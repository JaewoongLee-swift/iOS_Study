//
//  RankingFeatureSectionView.swift
//  AppStore
//
//  Created by 이재웅 on 2021/10/22.
//

import SnapKit
import UIKit
import SwiftUI

final class RankingFeatureSectionView: UIView {
    private var rankingFeatureList: [RankingFeature] = []
    
    private lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .black)
        label.text = "iPhone이 처음이라면"
        
        return label
    }()
    
    private lazy var showAllAppsButton: UIButton = {
        let button = UIButton()
        button.setTitle("모두보기", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        
        return button
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 32.0
        layout.minimumInteritemSpacing = 0.0
        layout.sectionInset = UIEdgeInsets(top: 0.0, left: 16.0, bottom: 0.0, right: 16.0)
    
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .systemBackground
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.register(
            RankingFeatureCollectionViewCell.self,
            forCellWithReuseIdentifier: "RankingFeatureCollectionViewCell"
        )
        
        return collectionView
    }()
    
    private let separatorView = SeparatorView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        fetchData()
        // setupView()는 텅텅 빈 배열을 기준으로 그려졌기 때문에 우리가 가져온 값을 제대로 표현하고 있지 않음. 따라서 CollectionView를 다시 그려줘야함
        collectionView.reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RankingFeatureSectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //CollectionView의 cell의 크기를 cellHeight으로 설정
        CGSize(width: collectionView.frame.width - 32.0, height: RankingFeatureCollectionViewCell.height)
    }
}

extension RankingFeatureSectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        rankingFeatureList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "RankingFeatureCollectionViewCell",
            for: indexPath
        ) as? RankingFeatureCollectionViewCell
        
        let rankingFeature = rankingFeatureList[indexPath.item]
        cell?.setup(rankingFeature: rankingFeature)
        
        return cell ?? UICollectionViewCell()
    }
    
}

//MARK: Private Method
extension RankingFeatureSectionView {
    func setupViews() {
        [
            titleLabel,
            showAllAppsButton,
            collectionView,
            separatorView
        ].forEach { addSubview($0) }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(32.0)
            $0.leading.equalToSuperview().inset(16.0)
            $0.trailing.equalTo(showAllAppsButton.snp.leading).offset(8.0)
        }
        
        showAllAppsButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16.0)
            $0.bottom.equalTo(titleLabel.snp.bottom)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16.0)
            // cellHeight 배수만큼 collectionView의 cell들이 보일것임
            $0.height.equalTo(RankingFeatureCollectionViewCell.height * 3)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        separatorView.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom).offset(16.0)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
    }
    
    func fetchData() {
        guard let url = Bundle.main.url(forResource: "RankingFeature", withExtension: "plist") else { return }
        do {
            let data = try Data(contentsOf: url)
            let result = try PropertyListDecoder().decode([RankingFeature].self, from: data)
            self.rankingFeatureList = result
        } catch {}
    }
}


