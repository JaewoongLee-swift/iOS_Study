//
//  RankingFeature.swift
//  AppStore
//
//  Created by 이재웅 on 2021/10/27.
//

import Foundation

struct RankingFeature: Decodable {
    let title: String
    let description: String
    let isInPurchaseApp: Bool
}
