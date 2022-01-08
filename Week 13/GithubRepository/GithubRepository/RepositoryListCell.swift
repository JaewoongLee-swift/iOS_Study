//
//  RepositoryListCell.swift
//  GithubRepository
//
//  Created by 이재웅 on 2022/01/07.
//

import UIKit
import SnapKit

class RepositoryListCell: UITableViewCell {
    var repository: Repository?
    
    let nameLabel = UILabel()
    let descriptionLabel = UILabel()
    let starImageView = UIImageView()
    let starLabel = UILabel()
    let languageLabel = UILabel()
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        [
            nameLabel, descriptionLabel, starImageView, starLabel, languageLabel
        ].forEach{
            contentView.addSubview($0)
        }
        
        guard let repository = repository else { return }
        nameLabel.text = repository.name
        nameLabel.font = .systemFont(ofSize: 15.0, weight: .bold)
        
        descriptionLabel.text = repository.description
        descriptionLabel.font = .systemFont(ofSize: 15.0)
        descriptionLabel.numberOfLines = 2
        
        starImageView.image = UIImage(systemName: "star")
        
        starLabel.text = "\(repository.stargazersCount)"
        starLabel.font = .systemFont(ofSize: 16.0)
        starLabel.tintColor = .gray
        
        languageLabel.text = repository.language
        languageLabel.font = .systemFont(ofSize: 16.0)
        languageLabel.tintColor = .gray
        
        nameLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(18.0)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(3.0)
            $0.leading.trailing.equalTo(nameLabel)
        }
        
        starImageView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(8.0)
            $0.leading.equalTo(nameLabel)
            $0.width.height.equalTo(20.0)
            $0.bottom.equalToSuperview().inset(18.0)
        }
        
        starLabel.snp.makeConstraints {
            $0.centerY.equalTo(starImageView)
            $0.leading.equalTo(starImageView.snp.trailing).offset(5.0)
        }
        
        languageLabel.snp.makeConstraints {
            $0.centerY.equalTo(starImageView)
            $0.leading.equalTo(starLabel.snp.trailing).offset(12.0)
        }
    }
}
