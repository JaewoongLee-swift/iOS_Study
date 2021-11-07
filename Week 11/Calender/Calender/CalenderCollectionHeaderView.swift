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
        label.text = "2021년11월"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        
        return label
    }()
    
    
}
