//
//  Feature.swift
//  AppStore
//
//  Created by 이재웅 on 2021/10/27.
//

import Foundation

struct Feature: Decodable {
    let type: String
    let appName: String
    let description: String
    let imageURL: String
}
