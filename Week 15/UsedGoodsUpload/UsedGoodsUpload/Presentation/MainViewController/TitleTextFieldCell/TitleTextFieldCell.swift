//
//  TitleTextFieldCell.swift
//  UsedGoodsUpload
//
//  Created by 이재웅 on 2022/02/02.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class TitleTextFieldCell: UITableViewCell {
    let disposeBag = DisposeBag()
    
    let titleInputField = UITextField()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: TitleTextFieldCellViewModel) {
        titleInputField.rx.text     // titleInputField에 텍스트가 입력되면, titleText에 바인드되도록 함
            .bind(to: viewModel.titleText)
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        titleInputField.font = .systemFont(ofSize: 17.0)
    }
    
    private func layout() {
        contentView.addSubview(titleInputField)
        
        titleInputField.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(20.0)
        }
    }
}
