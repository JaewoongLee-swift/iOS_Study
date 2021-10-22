//
//  TodayCollectionHeaderView.swift
//  AppStore
//
//  Created by 이재웅 on 2021/10/22.
//

import SnapKit
import UIKit

// Header와 footer가 되기 위해선 UICollectionReusableView를 상속해야 함
final class TodayCollectionHeaderView: UICollectionReusableView {
    private lazy var dateLabel: UILabel = {
       let label = UILabel()
        label.text = "10월 22일 금요일"
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .secondaryLabel
        
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.text = "투데이"
        label.font = .systemFont(ofSize: 36, weight: .black)
        label.textColor = .label
        
        return label
    }()
    
    func setupViews() {
        [dateLabel, titleLabel].forEach { addSubview($0) }
        
        dateLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16.0)
            $0.trailing.equalToSuperview()
            $0.top.equalToSuperview().inset(32.0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.left.equalTo(dateLabel)
            $0.top.equalTo(dateLabel.snp.bottom).offset(8.0)
        }
        
    }
}
