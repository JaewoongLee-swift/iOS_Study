//
//  DetailWriteFormCellViewModel.swift
//  UsedGoodsUpload
//
//  Created by 이재웅 on 2022/02/04.
//

import RxSwift
import RxCocoa

// 이곳에선 내용전달 기능만 있음
struct DetailWriteFormCellViewModel {
//    View -> ViewModel
    let contentValue = PublishRelay<String?>()
}
