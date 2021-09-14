//
//  ViewController.swift
//  analects
//
//  Created by 이재웅 on 2021/08/12.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var sayings: Saying = Saying(authors: authorFactory, sayings: sayings_Dic)
    
    var sayingCount = 0

    @IBOutlet weak var sayingLabel: UILabel!
    
    @IBAction func recycleButton(_ sender: UIButton) {
        if sayingCount == sayings.authors.count{
            sayings.authors.shuffle()
            sayingCount = 0
            print("명언 순서 초기화")
        }
        authorLabel.text = sayings.authors[sayingCount]
        sayingLabel.text = sayings.sayings[sayings.authors[sayingCount]]
        sayingCount += 1
    }
    
    @IBOutlet weak var authorLabel: UILabel!
    
    var sayings_Dic: [String: String] = ["빈스 롬바르디" : "자신감은 전염된다. 자신감의 부족도 마찬가지다.", "랄프 왈도 에머슨" : "얕은 사람은 행운을 믿으며, 강한 사람은 원인과 결과를 믿는다","피터 드러커" : "하지 말아야 할 것을 효율적으로 하는 것보다 더 비생산적인 것은 없다.", "프레드리히 빌헴름 니체" : "사랑에 의해 행해지는 것은 언제나 선악을 초월한다.", "소크라테스" : "가장 적은 것으로도 만족하는 사람이 가장 부유한 사람이다."]
    
    let authorFactory = ["빈스 롬바르디", "랄프 왈도 에머슨", "피터 드러커", "프레드리히 빌헴름 니체", "소크라테스"]


}

