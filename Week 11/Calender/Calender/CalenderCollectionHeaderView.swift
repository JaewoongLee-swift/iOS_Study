//
//  CalenderCollectionHeaderView.swift
//  Calender
//
//  Created by 이재웅 on 2021/11/07.
//

import SnapKit
import UIKit

final class CalenderCollectionHeaderView: UICollectionReusableView {
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        
        let headerLabel = headerLabel
        let nextButton = nextButton
        let previousButton = previousButton
        
        [headerLabel, nextButton, previousButton].forEach{ stackView.addArrangedSubview($0)
        }
        
        previousButton.snp.makeConstraints{
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview()
            $0.height.equalTo(32.0)
            $0.width.equalTo(48.0)
        }
        
        nextButton.snp.makeConstraints{
            $0.trailing.equalToSuperview()
            $0.top.equalTo(previousButton.snp.top)
            $0.height.equalTo(32.0)
            $0.width.equalTo(48.0)
        }
        
        headerLabel.snp.makeConstraints{
            $0.leading.equalTo(previousButton.snp.trailing)
            $0.trailing.equalTo(nextButton.snp.leading)
            $0.top.equalTo(previousButton.snp.top)
        }
        
       return stackView
    }()
    
    lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = "2021년11월"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        
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
}
