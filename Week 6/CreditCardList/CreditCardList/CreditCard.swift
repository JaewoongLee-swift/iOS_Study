//
//  CreditCard.swift
//  CreditCardList
//
//  Created by 이재웅 on 2021/09/29.
//

import Foundation

struct CreditCard: Codable {
    // json데이터의 key값들의 타입을 그대로 선언해줌
    let id: Int
    let rank: Int
    let name: String
    let cardImageURL: String
    let promotionDetail: PromotionDetail // PromotionDetail은 객체 안에 객체이므로 추가적으로 객체를 만들어줌
    let isSelected: Bool? // 추후에 사용자가 카드를 선택했을 때 나타날 것. 선택되기 전까진 nil값을 가질것이기 때문에 옵셔널
}
// PromotionDetail의 경우 뎁스를 가지는 정보이기 때문에 추가적으로 구조체를 선언해 줌

struct PromotionDetail: Codable {
    let companyName: String
    let amount: Int
    let period: String
    let benefitDate: String
    let benefitDetail: String
    let benefitCondition: String
    let condition: String
}
