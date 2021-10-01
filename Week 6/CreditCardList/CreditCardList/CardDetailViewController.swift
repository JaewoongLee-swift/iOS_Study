//
//  CardDetailViewController.swift
//  CreditCardList
//
//  Created by 이재웅 on 2021/09/30.
//

import UIKit
import Lottie

class CardDetailViewController: UIViewController {
    var promotionDetail: PromotionDetail?
    
    @IBOutlet weak var lottieView: AnimationView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var periodLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var benefitConditionLabel: UILabel!
    @IBOutlet weak var benefitDetailLabel: UILabel!
    @IBOutlet weak var benefitDateLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let animationView = AnimationView(name: "money")    // money는 lottie가 가져올 json파일의 파일명
        lottieView.contentMode = .scaleAspectFit            // 이미지뷰를 설정하는것과 비슷
        lottieView.addSubview(animationView)
        animationView.frame = lottieView.bounds             // 애니메이션 뷰의 프레임은 우리가 만들어놓은 로티뷰의 바운즈에 맞춤
        animationView.loopMode = .loop                      // 움직이는 이미지니까 반복을 어떻게 할거냐를 결정. .loop은 단순 반복
        animationView.play()                                // play()를 하면 viewDidLoad() 시에 작동을 할것임
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 못받았을 경우를 대비해 옵셔널(guard let)
        guard let detail = promotionDetail else { return }
        
        titleLabel.text = """
        \(detail.companyName)카드 쓰면
        \(detail.amount)만원 드려요
        """
        
        periodLabel.text = detail.period
        conditionLabel.text = detail.condition
        benefitConditionLabel.text = detail.benefitCondition
        benefitDetailLabel.text = detail.benefitDetail
        benefitDateLabel.text = detail.benefitDate
    }
    
}
