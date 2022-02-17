//
//  LocalNetwork.swift
//  FindCVS
//
//  Created by 이재웅 on 2022/02/17.
//

import RxSwift

class LocalNetwork {
    private let session: URLSession
    let api = LocalAPI()
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    // 네트워크연결이기 때문에 성공 or 실패값만 있으므로 Single로 값을 전달
    func getLocation(by mapPoint: MTMapPoint) -> Single<Result<LocationData, URLError>> {
        guard let url = api.getLocation(by: mapPoint).url else { return .just(.failure(URLError(.badURL))) }
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        // 우리는 Header에 값을 넣을 계획이기 떄문에 forKey가 아닌 forHTTPHeaderField에 값을 넣어줘야함
        request.setValue("KakaoAK 613d6c9c6a1ca2e828ad7bf94836182d", forHTTPHeaderField: "Authorization")
        
        return session.rx.data(request: request as URLRequest)
            .map { data in
                // json 디코딩
                do {
                    let locationData = try JSONDecoder().decode(LocationData.self, from: data)
                    return .success(locationData)
                } catch {
                    return .failure(URLError(.cannotParseResponse))
                }
            }
            .catch { _ in   .just(Result.failure(URLError(.cannotLoadFromNetwork))) }
            .asSingle()
    }
}
