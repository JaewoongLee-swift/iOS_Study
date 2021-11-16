//
//  SubwayDetailCollectionViewCell.swift
//  SubwayStation
//
//  Created by 이재웅 on 2021/11/16.
//

import UIKit
import SnapKit

class StationDetailCollectionViewCell: UICollectionViewCell {
    
    private lazy var lineLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15.0, weight: .bold)
        
        return label
    }()
    
    private lazy var remainTimeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15.0, weight: .medium)
        
        return label
    }()
    
    func setup() {
        lineLabel.text = "원주행 - 안동방면"
        remainTimeLabel.text = "곧 도착"
        
        layer.cornerRadius = 12.0
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 10
        
        //배경색이 없을 경우 cgColor를 설정하더라도 기준색이 없어 그림자가 표시되지 않음. 따라서 배경색 설정을 해줘야함.
        backgroundColor = .systemBackground
        
        [lineLabel, remainTimeLabel].forEach { addSubview($0) }
        
        lineLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16.0)
            $0.top.equalToSuperview().inset(16.0)
        }
        
        remainTimeLabel.snp.makeConstraints {
            $0.leading.equalTo(lineLabel.snp.leading)
            $0.top.equalTo(lineLabel.snp.bottom).offset(16.0)
            $0.bottom.equalToSuperview().inset(16.0)
        }
    }
}
