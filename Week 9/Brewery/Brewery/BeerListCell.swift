//
//  BeerListCell.swift
//  Brewery
//
//  Created by 이재웅 on 2021/10/17.
//

import UIKit
import Kingfisher
import SnapKit
import SwiftUI

class BeerListCell: UITableViewCell {
    let beerImageView = UIImageView()
    let nameLable = UILabel()
    let taglineLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        [beerImageView, nameLable, taglineLabel].forEach {
            contentView.addSubview($0)
        }
        
        beerImageView.contentMode = .scaleAspectFit
        
        nameLable.font = .systemFont(ofSize: 18, weight: .bold)
        nameLable.numberOfLines = 2
        
        taglineLabel.font = .systemFont(ofSize: 14, weight: .light)
        taglineLabel.textColor = .systemBlue
        taglineLabel.numberOfLines = 0
        
        beerImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.bottom.equalToSuperview().inset(20)
            $0.width.equalTo(80)
            $0.height.equalTo(120)
        }
        
        nameLable.snp.makeConstraints {
            $0.leading.equalTo(beerImageView.snp.trailing).offset(10)
            $0.bottom.equalTo(beerImageView.snp.centerY)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        taglineLabel.snp.makeConstraints {
            $0.leading.trailing.equalTo(nameLable)
            $0.top.equalTo(nameLable.snp.bottom).offset(5)
        }
    }
    
    
    func configure(with beer: Beer) {
        let imageURL = URL(string: beer.imageURL ?? "")
        beerImageView.kf.setImage(with: imageURL, placeholder: #imageLiteral(resourceName: "beer_icon"))
        nameLable.text = beer.name ?? "이름 없는 맥주"
        taglineLabel.text = beer.tagLine
        
        accessoryType = .disclosureIndicator    // 셀 옆에 꺽새모양의 버튼이 추가됨
        selectionStyle = .none                  // 셀을 탭하더라도 음영이 생기지 않음
    }
}
