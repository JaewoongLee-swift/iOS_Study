//
//  FeatureSectionView.swift
//  AppStore
//
//  Created by 이재웅 on 2021/10/22.
//

import SnapKit
import UIKit

final class FeatuerSectionView: UIView {
    private var featureList: [Feature] = []

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        // 가로로 스크롤이 되도록
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        // 페이징 가능하도록 설정
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .systemBackground
        // 스크롤바는 안보이도록 설정
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.register(
            FeatureSectionCollectionViewCell.self,
            forCellWithReuseIdentifier: "FeatureSectionCollectionViewCell"
            )
        
        return collectionView
    }()
    
    private let separatorView = SeparatorView(frame: .zero)
    
    // ViewController였으면 viewDidLoad()에 넣었지만 UIView이기 때문에 init에다 제약조건들을 실행시켜줌
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        
        fetchData()
        // collectionView는 데이터를 불러온 후 reloadData 필수
        collectionView.reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FeatuerSectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        featureList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeatureSectionCollectionViewCell", for: indexPath) as? FeatureSectionCollectionViewCell
        let feature = featureList[indexPath.item]
        cell?.setup(feature: feature)
    
        return cell ?? UICollectionViewCell()
    }
}

extension FeatuerSectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width - 32.0, height: frame.width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0.0, left: 16.0, bottom: 0, right: 16.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        32.0
    }
}

private extension FeatuerSectionView {
    func setupViews() {
        [
            collectionView,
            separatorView
        ].forEach { addSubview($0) }
        
        collectionView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.top.equalToSuperview().inset(16.0)
            $0.height.equalTo(snp.width)
            $0.bottom.equalToSuperview()
        }
        
        separatorView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.top.equalTo(collectionView.snp.bottom).offset(16.0)
            $0.height.equalTo(0.5)
        }
    }
    
    func fetchData() {
        guard let url = Bundle.main.url(forResource: "Feature", withExtension: "plist") else { return }
        
        do {
            let data = try Data(contentsOf: url)
            let result = try PropertyListDecoder().decode([Feature].self, from: data)
            featureList = result
        } catch {
            
        }
    }
}
