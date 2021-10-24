//
//  ExchageCodeButtonView.swift
//  AppStore
//
//  Created by 이재웅 on 2021/10/22.
//

import SnapKit
import UIKit

final class ExchangeCodeButtonView: UIView {
    private lazy var exchangeCodeButton: UIButton = {
        let button = UIButton()
        button.setTitle("코드 교환", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15.0, weight: .semibold)
        
        button.layer.cornerRadius = 7.0
        button.backgroundColor = .tertiarySystemGroupedBackground
        
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(exchangeCodeButton)
        
        exchangeCodeButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16.0)
            $0.trailing.equalToSuperview().inset(16.0)
            $0.bottom.equalToSuperview().inset(32.0)
            $0.top.equalToSuperview().inset(32.0)
            $0.height.equalTo(40)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
