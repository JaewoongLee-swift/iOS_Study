//
//  CardListViewController.swift
//  CreditCardList
//
//  Created by 이재웅 on 2021/09/29.
//

import UIKit
import Kingfisher
import FirebaseDatabase

class CardListViewController: UITableViewController {
    /* UIViewController와 UITableViewController의 차이점은?
     단순히 UIViewController에 TableView를 넣어주면 되는것 아닌가?
     1. UITableViewController는 UITableView를 구성하기 위해 필요한 Delegate와 datasource를 기본 연결한 상태로 제공하기 때문에 별도로 delegate를 선언하지 않아도 됨
     2. Rootview로 UITableView를 가지게 됨
     */
    var ref: DatabaseReference!     //Firebase Realtime Database
    
    var creditCardList: [CreditCard] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UITableVIew Cell Register
        let nibName = UINib(nibName: "CardListCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "CardListCell")
        
        ref = Database.database().reference()
        
        ref.observe(.value) { snapshot in
            guard let value = snapshot.value as? [String: [String: Any]] else { return }
            // json 디코딩. json 디코딩은 try문임
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: value)
                let cardData = try JSONDecoder().decode([String: CreditCard].self, from: jsonData)
                let cardList = Array(cardData.values)   // Dictionary니까 Value값만 가져올것임
                self.creditCardList = cardList.sorted { $0.rank < $1.rank } // 카드순위 순서대로 정렬해줌
                // tableview를 reload해줄것임 >> reload는 UI의 움직임 >> UI는 메인스레드에서 제공됨 >> 클로저 안에서도 메인에서 돌도록 지정해줘야함
                // 메인 스레드에 해당 액션을 넣어주는 과정
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }   // 이렇게 하면 creditcard 데이터를 불러온 다음에 Reload를 할것임
                
            } catch let error {
                print("ERROR JSON parsing \(error.localizedDescription)")
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return creditCardList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CardListCell", for: indexPath) as? CardListCell else { return UITableViewCell() }
        cell.rankLabel.text = "\(creditCardList[indexPath.row].rank)위"
        cell.promotionLabel.text = "\(creditCardList[indexPath.row].promotionDetail.amount)만원 증정"
        cell.cardNameLabel.text = "\(creditCardList[indexPath.row].name)"
        
        let imageURL = URL(string: creditCardList[indexPath.row].cardImageURL)
        cell.cardImageView.kf.setImage(with: imageURL)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 상세화면 전달
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let detailViewController = storyboard.instantiateViewController(identifier: "CardDetailViewController") as? CardDetailViewController else { return }
        
        detailViewController.promotionDetail = creditCardList[indexPath.row].promotionDetail
        self.show(detailViewController, sender: nil)
        
        
        let cardID = creditCardList[indexPath.row].id
        //Option1
//        ref.child("Item\(cardID)/isSelected").setValue(true)
        //Option2
        // reference에 queryOrdered라는 걸로 id를 검색함. id에 있는 value가 cardID의 value와 같은걸 가져오라고 명령하는것임
        // 그 다음 그것의 .observe(.value)를 통해 value값을 보는것. 다음 snapshot을 통해 가져오는것임. (weak self는 순환참조방지)
        ref.queryOrdered(byChild: "id").queryEqual(toValue: cardID).observe(.value) { [weak self]snapshot in
            guard let self = self,  // 데이터 읽기와 비슷함
                  let value = snapshot.value as? [String: [String:Any]],
                  let key = value.keys.first else { return }    //keys는 value의 key의 첫번째 값을 가져와라.
            
            //reference의 Child의 key에 해당하는 것을 isSelected를 변경하도록 설정할 수 있음.
            self.ref.child("\(key)/isSelceted").setValue(true)
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {    // UITableView에 있는 다양한 editing스타일중에서 delete를 선택할 것임.
            // 삭제를 누르면 어떤 액션을 취할것인지 작성
            let cardID = creditCardList[indexPath.row].id
            //Option1
            ref.child("Item\(cardID)").removeValue()
            
            //Option2(경로를 모를떄)
//            ref.queryOrdered(byChild: "id").queryEqual(toValue: cardID).observe(.value) { [weak self] snapshot in
//                guard let self = self,
//                      let value = snapshot.value as? [String: [String:Any]],
//                      let key = value.keys.first else { return }
//                ref.child(key).removeValue()
//            }
        }
    }
}
