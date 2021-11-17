//
//  StationResponseModel.swift
//  SubwayStation
//
//  Created by 이재웅 on 2021/11/17.
//

// Response 모델, 필요한 Response값을 Codable로 사용하기 위한 모델을 정의(모델용 Swift 파일)

import Foundation

struct StationResponseModel: Decodable {
// 변수 searchInfo를 통해서 row의 값을 빼낼때 코드가 복잡해질 수 있기때문에 searchInfo는 private 해주고 변수 stations을 새로 선언해 코드를 간단하게 작성
// 기존 : StationResponseModel().searchInfo.row
// 변경 : StationResponseModel().stations 이쪽의 코드가 더 간단하게 됨
    var stations: [Station] { searchInfo.row }
    private let searchInfo: SearchInfoBySubwayNameServiceModel
    
    enum CodingKeys: String, CodingKey {
        case searchInfo = "SearchInfoBySubwayNameService"
    }
    
    struct SearchInfoBySubwayNameServiceModel: Decodable {
        var row: [Station] = []
    }
    
}

struct Station: Decodable {
    var stationName: String
    var lineNumber: String
    
    enum CodingKeys: String, CodingKey {
        case stationName = "STATION_NM"
        case lineNumber = "LINE_NUM"
    }
}
