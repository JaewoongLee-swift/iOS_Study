//
//  CalenderTableViewCell.swift
//  Calender
//
//  Created by 이재웅 on 2022/01/13.
//

import UIKit
import SnapKit

class CalenderTableViewCell: UITableViewCell {
    let name: String = "이재웅"
    let startTime: Int = 8
    let finishTime: Int = 10
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = name
        label.font = .systemFont(ofSize: 15.0, weight: .semibold)
        
        return label
    }()
    
    lazy var exerciseHourLabel: UILabel = {
        let label = UILabel()
        label.text = "\(startTime)시 ~ \(finishTime)시"
        label.font = .systemFont(ofSize: 15.0, weight: .medium)
        
        return label
    }()
    
    func setSubViews() {
        [nameLabel, exerciseHourLabel].forEach{ addSubview($0) }
        
        nameLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(10)
        }
        
        exerciseHourLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(10)
        }
    }
    
}
