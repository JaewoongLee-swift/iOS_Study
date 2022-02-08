//
//  MainModel.swift
//  UsedGoodsUpload
//
//  Created by 이재웅 on 2022/02/08.
//

import RxSwift
import RxCocoa

struct MainModel {
    func setAlert(errorMessage: [String]) -> Alert {
        let title = errorMessage.isEmpty ? "성공" : "실패"
        let message = errorMessage.isEmpty ? nil : errorMessage.joined(separator: "\n")
        return (title: title, message: message ?? "")
    }
}
