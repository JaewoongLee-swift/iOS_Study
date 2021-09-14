//
//  ColorController.swift
//  ElectricDisplay_2nd
//
//  Created by 이재웅 on 2021/08/31.
//

import UIKit

protocol colorDelegate {
    func sendColor(color: UIColor)
}

class ColorController: UIViewController {
    var delegate: colorDelegate?
    
    
    @IBAction func colorButton(_ sender: UIButton) {
        if let color = sender.backgroundColor {
            print("버튼의 색상은 \(color.accessibilityName)입니다.")
            delegate?.sendColor(color: color)
            dismiss(animated: true, completion: nil)
        }
        
    }
    
    @IBOutlet var colorButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for button in colorButtons {
            button.layer.cornerRadius = button.frame.width/2
        }
        
        // Do any additional setup after loading the view.
    }
    
}


