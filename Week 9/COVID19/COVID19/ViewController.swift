//
//  ViewController.swift
//  COVID19
//
//  Created by 이재웅 on 2021/10/15.
//

import UIKit

import Alamofire
import Charts

class ViewController: UIViewController {
    @IBOutlet weak var totalCaseLabel: UILabel!
    @IBOutlet weak var newCaseLabel: UILabel!
    @IBOutlet weak var pieChartView: PieChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchCovidOverview(completionHandler: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let.success(result):
                debugPrint("success: \(result)")
            case let.failure(error):
                debugPrint("error: \(error)")
            }
        })

    }
        // @escaping에 관하여
    /*
     escaping 클로저는 함수가 escaping한다는 의미. 함수의 인자로 클로저가 전달되지만 함수가 반환된 후에도 실행되는 것을 뜻함.
     
     함수의 인자가 함수의 영역을 탈출하여 함수 밖에서도 사용할 수 있는 경우는 기존의 우리가 알고있는 변수의 scope 개념을 완전히 무시. 왜냐하면 함수에서 선언된 로컬변수와 로컬변수의 영역을 뛰어넘어 함수 밖에서도 유효하기 때문.
     
     escaping 클로저를 사용하는 대표적인 예시 : 비동기 작업을 하는 경우 completionHandler로 escaping을 사용
     보통 네트워킹은 비동기적으로 작업되기 때문에 코드에서와 같이 response 데이터 메소드 파라미터에서 정의한 completionHandler 클로저는  fetchCovidOverview함수가 반환된 이후에 호출이 됨. 그 이유는, 서버에서 데이터를 언제 응답시켜줄지 모르기 때문. 그렇기 때문에 escaping 클로저로 completionHandler를 정의하지 않는다면 서버에서 비동기로 데이터를 응답받기 전, 즉 response 데이터 메소드 파라미터에 정의한 completionHandler 클로저가 호출되기 전에 함수가 종료되서 서버의 응답을 받아도 fetchCovidOverview에서 정의한 completionHandler가 호출되지 않을것. 그래서 함수 내에서 비동기 작업을 하고 비동기 작업의 결과를 completionHandler로 Callback을 시켜줘야 한다면 escaping클로저를 사용하여 함수가 반환된 다음에도 실행되게 만들어 줘야함.
     */
    func fetchCovidOverview(completionHandler: @escaping (Result<CityCovidOverview, Error>) -> Void) {
        let url = "https://api.corona-19.kr/korea/country/new/"
        let param = [
            "serviceKey" : "n7isr9PqY8eV251c6CvtbNXoxF3DkOKml"
        ]
        
        AF.request(url, method: .get, parameters: param).responseData(completionHandler: { response in
            switch response.result {
            case let .success(data):
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(CityCovidOverview.self, from: data)
                    completionHandler(.success(result))
                } catch {
                    completionHandler(.failure(error))
                }
            case let .failure(error):
                completionHandler(.failure(error))
            }
            
            
        })
    }

}

