//
//  PriceTextFieldCellVeiwModel.swift
//  UsedGoodsUpload
//
//  Created by 이재웅 on 2022/02/04.
//

import RxSwift
import RxCocoa

struct PriceTextFieldCellVeiwModel {
//    ViewModel -> View
    let showFreeShareButton: Signal<Bool>
    let resetPrice: Signal<Void>
    
//    View -> ViewModel
    let priceValue = PublishRelay<String?>()
    let freeShareButtonTapped = PublishRelay<Void>()
    
    init() {
        self.showFreeShareButton = Observable
            .merge(
                priceValue.map { $0 ?? "" == "0" },
                freeShareButtonTapped.map { _ in false } // 버튼을 누르면 무료나눔버튼을 숨기는 기능
            )
            .asSignal(onErrorJustReturn: false)
        
        self.resetPrice = freeShareButtonTapped
            .asSignal(onErrorSignalWith: .empty())
    }
    
}
