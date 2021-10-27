//
//  TodayCollectionviewCell.swift
//  AppStore
//
//  Created by 이재웅 on 2021/10/22.
//

import SnapKit
import Kingfisher
import UIKit

final class TodayCollectionViewCell: UICollectionViewCell {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .white
        
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .white
        
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .white
        
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        // contentMode.scaleAspectFill : view에 꽉차도록 content가 들어감
        // contentMode.scaleAspectFit : view에 들어갈 수 있도록 aspect ratio를 유지하면서 크기를 조절함
        imageView.contentMode = .scaleAspectFill    // 꽉 채울것이니 scaleAspectFill
        imageView.clipsToBounds = true              // 이미지뷰가 셀의 크기보다 클 경우 잘라넣기 위함.
        imageView.layer.cornerRadius = 12.0
        imageView.backgroundColor = .gray
        
        return imageView
    }()
    
    func setup(today: Today) {
        setupSubViews()
        
        // 그림자 설정. 그림자는 셀 자체에서 구현 필요
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 10
        
        titleLabel.text = today.title
        subTitleLabel.text = today.subTitle
        descriptionLabel.text = today.description
        
        if let imageURL = URL(string: today.imageURL) {
            imageView.kf.setImage(with: imageURL)
        }
    }
}

private extension TodayCollectionViewCell {
    func setupSubViews() {
        [imageView, titleLabel, subTitleLabel, descriptionLabel]
            .forEach { addSubview($0) }
        
        subTitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(24.0)
            $0.trailing.equalToSuperview().inset(24.0)
            $0.top.equalToSuperview().inset(24.0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(subTitleLabel)
            $0.trailing.equalTo(subTitleLabel)
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(4.0)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(24.0)
            $0.trailing.equalToSuperview().inset(24.0)
            $0.bottom.equalToSuperview().inset(24.0)
        }
        
        //주의 : 이미지뷰는 셀의 사이즈와 똑같기 때문에 사이즈를 똑같이 superview와 같게 해야함
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
