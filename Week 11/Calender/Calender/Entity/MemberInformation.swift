//
//  MemberInformation.swift
//  Calender
//
//  Created by 이재웅 on 2022/02/02.
//

import Foundation

struct MemberInformation: Decodable {
    let name: String?
    let date: String?
    let startTime: Int?
    let finishTime: Int?
    let type: String?
    let memo: String?
}
