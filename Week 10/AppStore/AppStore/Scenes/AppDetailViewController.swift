//
//  AppDetailViewController.swift
//  AppStore
//
//  Created by 이재웅 on 2021/10/25.
//

import SnapKit
import Kingfisher
import UIKit

final class AppDetailViewController: UIViewController {
    private let today: Today
    
    private let appIconImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8.0
        
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 20.0, weight: .bold)
        label.textColor = .label
        
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 14.0, weight: .medium)
        label.textColor = .secondaryLabel
        
        return label
    }()
    
    private let downloadButton: UIButton = {
        let button = UIButton()

        button.setTitle("받기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.titleLabel?.font = .systemFont(ofSize: 13.0, weight: .bold)
        button.layer.cornerRadius = 12.0
        
        return button
    }()
    
    private let shareButton: UIButton = {
        let button = UIButton()
        
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        button.tintColor = .systemBlue
        button.addTarget(self, action: #selector(didTapShareButton), for: .touchUpInside)
        
        return button
    }()
    
    init(today: Today) {
        self.today = today
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground        // darkmode로 설정할 경우 검은색, 기본일땐 흰색으로 나타나는 배경색
//        UILabel().textColor = .label 위와 같은 개념. darkmode에 호환되는 색상
        
        setupViews()
        appIconImageView.backgroundColor = .lightGray
        titleLabel.text = today.title
        subTitleLabel.text = today.subTitle
    }
}

// MARK: Private
private extension AppDetailViewController {
    func setupViews() {
        [
            appIconImageView,
            titleLabel,
            subTitleLabel,
            downloadButton,
            shareButton
        ].forEach { view.addSubview($0) }
        
        appIconImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16.0)
            $0.top.equalToSuperview().inset(32.0)
            $0.height.equalTo(100.0)
            $0.width.equalTo(appIconImageView.snp.height)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(appIconImageView.snp.trailing).offset(16.0)
            $0.top.equalTo(appIconImageView.snp.top)
            $0.trailing.equalToSuperview().inset(16.0)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.top.equalTo(titleLabel.snp.bottom).offset(4.0)
            $0.trailing.equalToSuperview().inset(16.0)
        }
        
        downloadButton.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.bottom.equalTo(appIconImageView.snp.bottom)
            $0.width.equalTo(60.0)
            $0.height.equalTo(24.0)
        }
        
        shareButton.snp.makeConstraints {
            $0.bottom.equalTo(downloadButton.snp.bottom)
            $0.trailing.equalToSuperview().inset(16.0)
            $0.width.equalTo(32.0)
            $0.height.equalTo(32.0)
        }
    }
    
    // addTarget 메소드의 파라미터, action의 Selector는 objective-C의 함수를 이용해야 함
    @objc func didTapShareButton() {
        let activityItems: [Any] = [today.title]
        let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        
        present(activityViewController, animated: true, completion: nil)
    }
}
