//
//  CalenderCollectionCell.swift
//  Calender
//
//  Created by 이재웅 on 2021/11/07.
//

import SnapKit
import UIKit

final class CalenderCollectionCell: UICollectionViewCell {
    lazy var dataLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .light)
        label.textColor = .black
        
        return label
    }()
    
    func setupSubViews() {
        addSubview(dataLabel)
        
        dataLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
    }
}

