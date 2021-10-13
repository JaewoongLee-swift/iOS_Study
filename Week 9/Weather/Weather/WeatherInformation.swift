//
//  WeatherInformation.swift
//  Weather
//
//  Created by 이재웅 on 2021/10/13.
//

import Foundation
// 날씨 정보를 저장하는 구조체

/*
Codable 프로토콜 : 자신을 변환하거나 외부 파일로 변환할 수 있는 타입. 외부표현이란? json과 같은 타입
Decodable : 자신을 외부 표현에서 디코딩 할 수 있는 타입
Incodable : 자신을 외부 표현에서 인코딩 할 수 있는 타입
Codable을 채택한 것은 json 디코딩, 인코딩 모두 할 수 있다는 것. 한마디로 WeatherInformation 구조체를 Codable로 채택하면, 이 구조체를 Json으로 만들 수 있고, Json을 WeatherInformation으로 만들 수 있다는 것.
Codable을 채택하여 서버에서 전달받은 날씨 Json파일을 WeatherInformation으로 변환하는 작업, 즉 디코딩을 구현할 것
 */

struct WeatherInformation: Codable {
    // 필요한 프로퍼티만 구현
    let weather: [Weather]
    let temp: Temp
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case weather
        case temp = "main"
        case name
    }
}
struct Weather: Codable {
    // json 형태의 데이터로 변환하기 위해선 json의 키, 밸류와 사용자가 정의한 프로퍼티 명, 타입형태가 동일해야함
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Temp: Codable {
    let temp: Double
    let feelsLike: Double
    let minTemp: Double
    let maxTemp: Double
    
    // json의 키와 프로퍼티의 이름이 달라도 매핑될 수 있도록 해보자
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case minTemp = "temp_min"
        case maxTemp = "temp_max"
    }
}
