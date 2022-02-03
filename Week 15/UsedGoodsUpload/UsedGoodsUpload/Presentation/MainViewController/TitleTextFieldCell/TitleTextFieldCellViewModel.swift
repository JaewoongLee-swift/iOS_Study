//
//  TitleTextFieldCellViewModel.swift
//  UsedGoodsUpload
//
//  Created by 이재웅 on 2022/02/02.
//


// TitleTextField가 할 일
// 1. 텍스트 입력
// 2. 부모뷰로 텍스트 데이터 전달
// 3. 텍스트가 입력되었는지 확인

import RxCocoa

struct TitleTextFieldCellViewModel {
    let titleText = PublishRelay<String?>()
}
