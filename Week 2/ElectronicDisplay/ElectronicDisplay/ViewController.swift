//
//  ViewController.swift
//  ElectronicDisplay
//
//  Created by 이재웅 on 2021/08/18.
//

import UIKit
import MarqueeLabel

class ViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet var colorButtons: [UIButton]!
    
    @IBAction func inputButton(_ sender: UIButton) {
        textLabel.text = inputText.text
    }
    
    @IBOutlet weak var inputText: UITextField!
    
    @IBOutlet weak var textLabel: UILabel!
    
    @IBAction func changeColorButton(_ sender: UIButton) {
        textLabel.textColor = sender.backgroundColor
    }


    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputText.delegate = self
        
        for index in colorButtons.indices {
            colorButtons[index].layer.cornerRadius = colorButtons[index].layer.frame.size.width/2
        }
    
        // Do any additional setup after loading the view.
    }


}
