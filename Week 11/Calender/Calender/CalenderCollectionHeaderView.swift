//
//  CalenderCollectionHeaderView.swift
//  Calender
//
//  Created by 이재웅 on 2021/11/07.
//

import SnapKit
import UIKit

final class CalenderCollectionHeaderView: UICollectionReusableView {
    
    lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        
        return label
    }()
    
    lazy var nextButton: UIButton = {
       let button = UIButton()
        button.setTitle("next", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        
        return button
    }()

    lazy var previousButton: UIButton = {
       let button = UIButton()
        button.setTitle("prev", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        
        return button
    }()
    
    func setupViews(Calendar: Calender) {
        [headerLabel, nextButton, previousButton].forEach{
            addSubview($0)
        }
        
        previousButton.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(16.0)
            $0.top.equalToSuperview().inset(8.0)
            $0.height.equalTo(32.0)
            $0.width.equalTo(48.0)
        }
        
        nextButton.snp.makeConstraints{
            $0.trailing.equalToSuperview().inset(16.0)
            $0.top.equalTo(previousButton.snp.top)
            $0.height.equalTo(32.0)
            $0.width.equalTo(48.0)
        }
        
        headerLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(previousButton.snp.bottom)
        }
        
        headerLabel.text = Calendar.yearMonthLabel
    }
}
