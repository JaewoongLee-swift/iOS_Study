//
//  SearchBlogNetwork.swift
//  SearchDaumBlog
//
//  Created by 이재웅 on 2022/01/18.
//

import RxSwift
import Foundation

enum SearchNetworkError: Error {
    // url오류
    case invalidURL
    // json오류
    case invalidJSON
    // 네트워크 오류
    case networkError
}

class SearchBlogNetwork {
    private let session: URLSession
    let api = SearchBlogAPI()
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    //네트워크 연결은 성공, 실패로 결과가 나오기때문에 Single타입으로 내보냄
    func searchBlog(query: String) -> Single<Result<DKBlog, SearchNetworkError>>{
        guard let url = api.searchBlog(query: query).url else { return .just(.failure(.invalidURL)) }
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("KakaoAK 52a8c1bec1f23a7738248fa6cbebedd6", forHTTPHeaderField: "Authorization")
        
        return session.rx.data(request: request as URLRequest)
            .map { data in
                do {
                    let blogData = try JSONDecoder().decode(DKBlog.self, from: data)
                    return .success(blogData)
                } catch {
                    return .failure(.invalidJSON)
                }
            }
            .catch { _ in
                .just(.failure(.networkError))
            }
            .asSingle()
    }
}
