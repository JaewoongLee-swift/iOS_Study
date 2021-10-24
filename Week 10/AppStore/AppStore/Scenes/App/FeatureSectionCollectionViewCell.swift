//
//  FeatureSectionCollectionViewCell.swift
//  AppStore
//
//  Created by 이재웅 on 2021/10/22.
//

import SnapKit
import UIKit

final class FeatureSectionCollectionViewCell: UICollectionViewCell {
    private lazy var typeLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 12.0, weight: .semibold)
        label.textColor = .systemBlue
        
        return label
    }()
    
    private lazy var appNameLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 20.0, weight: .bold)
        label.textColor = .label
        
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 16.0, weight: .semibold)
        label.textColor = .secondaryLabel
        
        return label
    }()
    
    private lazy var imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.layer.cornerRadius = 7.0
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor.separator.cgColor
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        
        
        return imageView
    }()
    
    func setup() {
        setupLayout()
        
        typeLabel.text = "typeLabel"
        appNameLabel.text = "appNameLabel"
        descriptionLabel.text = "descriptionLabel"
        imageView.backgroundColor = .yellow
    }
}

private extension FeatureSectionCollectionViewCell {
    func setupLayout() {
        [
        typeLabel,
        appNameLabel,
        descriptionLabel,
        imageView
        ].forEach{ addSubview($0) }
    
    
        typeLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.top.equalToSuperview()
        }
    
        appNameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.top.equalTo(typeLabel.snp.bottom)
        }
    
        descriptionLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.top.equalTo(appNameLabel.snp.bottom).offset(4)
        }
    
        imageView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(8)
            $0.bottom.equalToSuperview().inset(8.0)
        }
    }
}
