//
//  RankingFeatureCollectionViewCell.swift
//  AppStore
//
//  Created by 이재웅 on 2021/10/22.
//

import SnapKit
import UIKit

final class RankingFeatureCollectionViewCell: UICollectionViewCell {
    static var height: CGFloat { 70.0 }
    
    private lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 16.0, weight: .bold)
        
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        label.textColor = .secondaryLabel
         
         return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 7.0
        imageView.layer.borderWidth = 0.5
//        imageView.layer.borderColor = CGColor(.separator)
        imageView.backgroundColor = .tertiarySystemGroupedBackground
        
        return imageView
    }()
    
    private lazy var downloadButoon: UIButton = {
        let button = UIButton()
        button.setTitle("받기", for: .normal)
        button.setTitleColor(.systemBlue,for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 13.0, weight: .bold)
        button.backgroundColor = .secondarySystemBackground
        button.layer.cornerRadius = 12.0
        
        return button
    }()
    
    private lazy var inAppPurchaseInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "앱 내 구입"
        label.font = .systemFont(ofSize: 10.0, weight: .semibold)
        label.textColor = .secondaryLabel
         
         return label
    }()
    
    func setup() {
        setupViews()
        
        titleLabel.text = "앱 이름"
        descriptionLabel.text = "앱에 대한 설명란"
        inAppPurchaseInfoLabel.isHidden = [true, false].randomElement() ?? true
    }
}
private extension RankingFeatureCollectionViewCell {
    func setupViews() {
        [
            titleLabel,
            descriptionLabel,
            imageView,
            downloadButoon,
            inAppPurchaseInfoLabel
        ].forEach { addSubview($0) }
        
        imageView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview().inset(4.0)
            $0.bottom.equalToSuperview().inset(4.0)
            $0.width.equalTo(imageView.snp.height)
        }
        
        downloadButoon.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(24.0)
            $0.width.equalTo(50.0)
        }
        
        inAppPurchaseInfoLabel.snp.makeConstraints {
            $0.centerX.equalTo(downloadButoon.snp.centerX)
            $0.top.equalTo(downloadButoon.snp.bottom).offset(4.0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(imageView.snp.trailing).offset(8)
            $0.trailing.equalTo(downloadButoon.snp.leading)
            $0.top.equalToSuperview().inset(8.0)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4.0)
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.trailing.equalTo(titleLabel.snp.trailing)
        }
    }
}
