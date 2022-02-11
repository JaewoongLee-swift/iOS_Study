//
//  DetailListBackgroundViewModel.swift
//  FindCVS
//
//  Created by 이재웅 on 2022/02/11.
//

import RxSwift
import RxCocoa

struct DetailListBackgroundViewModel {
    //viewModel -> view
    let isStatusLabelHidden: Signal<Bool>
    
    //외부에서 전달받을 값
    let shouldHideStatusLabel = PublishSubject<Bool>()
    
    init() {
        isStatusLabelHidden = shouldHideStatusLabel
            .asSignal(onErrorJustReturn: true)
    }
}
