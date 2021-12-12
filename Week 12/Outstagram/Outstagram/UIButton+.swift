//
//  UIButton+.swift
//  Outstagram
//
//  Created by 이재웅 on 2021/12/10.
//

import UIKit

// 버튼의 이미지 사이즈를 통일하기 위함
extension UIButton {
    func setImage(systemName: String) {
        contentHorizontalAlignment = .fill
        contentVerticalAlignment = .fill
        
        imageView?.contentMode = .scaleAspectFit
        
        setImage(UIImage(systemName: systemName), for: .normal)
    }
}
