//
//  BeerListViewController.swift
//  Brewery
//
//  Created by 이재웅 on 2021/10/17.
//

import UIKit

class BeerListViewController: UITableViewController {
    var beerList = [Beer]()
    var currentPage = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UINavigationBar
        title = "패캠브루어리"
        navigationController?.navigationBar.prefersLargeTitles = true   //네비게이션 바를 큰 타이틀 형태로 보여주기
        
        //UITableView 설정
        tableView.register(BeerListCell.self, forCellReuseIdentifier: "BeerListCell") // 셀 등록
        tableView.rowHeight = 150
        
        fetchBeer(of: currentPage)
    }
}

//UITableView DataSource, Delegate
extension BeerListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beerList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BeerListCell", for: indexPath) as? BeerListCell else { return UITableViewCell() }
        // 동일하지만 guard문을 사용하지 않음
//        let cell = tableView.dequeueReusableCell(withIdentifier: "BeerListCell", for: indexPath) as! BeerListCell
                
        let beer = beerList[indexPath.row]
        cell.configure(with: beer)
                
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedBeer = beerList[indexPath.row]
        let detailViewController = BeerDetailViewController()
        
        detailViewController.beer = selectedBeer
        self.show(detailViewController, sender: nil)
    }
}

//Data Fetching
private extension BeerListViewController {
    func fetchBeer(of page: Int) {
        guard let url = URL(string: "https://api.punkapi.com/v2/beers?page=\(page)") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: request) {[weak self] data, response, error in
            guard error == nil,
                  let self = self,
                  let response = response as? HTTPURLResponse,
                  let data = data,
                  let beers = try? JSONDecoder().decode([Beer].self, from: data) else {
                      print("ERROR: URLSession data task \(error?.localizedDescription ?? "")")
                      return
            }
            
            switch response.statusCode {
            case (200..<300):   //성공
                self.beerList += beers
                self.currentPage += 1       // 한 페이지를 보여줬으니 그 다음페이지를 보여주게끔 +1을 해줌
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case (400..<500):   //클라이언트 에러
                print("""
                ERROR: Client ERROR \(response.statusCode)
                Response: \(response)
                """)
            case (500..<600):   //서버 에러
                print("""
                ERROR: Client ERROR \(response.statusCode)
                Response: \(response)
                """)
            default:
                print("""
                ERROR: Client ERROR \(response.statusCode)
                Response: \(response)
                """)
            }
        }
        dataTask.resume()
    }
}
