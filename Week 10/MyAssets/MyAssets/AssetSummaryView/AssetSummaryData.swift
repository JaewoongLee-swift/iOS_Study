//
//  AssetSummaryData.swift
//  MyAssets
//
//  Created by 이재웅 on 2021/10/21.
//

import SwiftUI

//데이터 모델에서 Asset을 내뱉어 준것.
//load함수를 통해 Asset.json을 디코딩해서 Publish 해준것. AssetSummaryView는 이것을 받아 바로 표현한 것
class AssetSummaryData: ObservableObject {
    @Published var assets: [Asset] = load("assets.json") //어떤 데이터를 내보낼 것인지 표현
}

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
        fatalError("\(filename)을 찾을 수 없습니다")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("\(filename)을 찾을 수 없습니다")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("\(filename)을 \(T.self)로 파싱할 수 없습니다")
    }
}
