//
//  CalenderTableViewCell.swift
//  Calender
//
//  Created by 이재웅 on 2022/01/13.
//

import UIKit
import SnapKit

class CalenderTableViewCell: UITableViewCell {
    let jaewoong = MemberInformation(
        name: "이재웅",
        date: "",
        startTime: 8,
        finishTime: 10,
        type: "",
        memo: ""
    )
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = jaewoong.name
        label.font = .systemFont(ofSize: 15.0, weight: .semibold)
        
        return label
    }()
    
    lazy var exerciseHourLabel: UILabel = {
        let label = UILabel()
        label.text = "\(jaewoong.startTime ?? 0)시 ~ \(jaewoong.finishTime ?? 0)시"
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
