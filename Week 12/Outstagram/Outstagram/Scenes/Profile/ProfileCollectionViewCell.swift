//
//  ProfileCollectionViewCell.swift
//  Outstagram
//
//  Created by 이재웅 on 2021/12/13.
//

import UIKit
import SnapKit

final class ProfileCollectionViewCell: UICollectionViewCell {
    private let imageView = UIImageView()
    
    func setup(with image: UIImage) {
        addSubview(imageView)
        imageView.snp.makeConstraints{ $0.edges.equalToSuperview() }
        
        imageView.backgroundColor = .tertiaryLabel
    }
}
