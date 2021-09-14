//
//  ViewController.swift
//  ElectricDisplay_2nd
//
//  Created by 이재웅 on 2021/08/30.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var inputText: UITextField!
    
    
    @IBAction func inputButton(_ sender: UIButton) {
        outputText.text = inputText.text
        outputText.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        if let text = inputText.text {
            print("텍스트 필드의 \"\(text)\"가 정상적으로 옮겨졌습니다. ")
        }
        inputText.text = ""
    }
    
    @IBOutlet weak var outputText: UILabel!
    
    
    @IBAction func colorButton(_ sender: UIButton) {
        changeColor(button: sender)
        if let color = sender.backgroundColor?.accessibilityName {
            print("Label의 텍스트 색상이 \(color)로 변경되었습니다.")
        }
    }
    
    @IBOutlet var colorButtons: [UIButton]!
    
    @IBAction func alphaButton(_ sender: UIButton) {
        UIView.animate(withDuration: 2, delay: 0.3, options: options, animations: { [weak self] in self?.outputText.alpha = 0}, completion: nil)
        print("깜박임 버튼이 정상적으로 클릭되었습니다.")
    }
    
    @IBAction func scaleButton(_ sender: UIButton) {
        UIView.animate(withDuration: 1, delay: 0.3, options: options, animations: { [weak self] in self?.outputText.transform = CGAffineTransform(scaleX: 2, y: 2)}, completion: nil)
        print("강조 버튼이 정상적으로 클릭되었습니다.")
    }
    
    @IBAction func moveColorscope(_ sender: UIButton) {
       if let controller = self.storyboard?.instantiateViewController(identifier: "ColorController") as? ColorController {
            print("색상표가 나타났습니다.")
            controller.modalTransitionStyle = .coverVertical
            controller.delegate = self
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    let options: UIView.AnimationOptions = [.curveEaseInOut, .repeat, .autoreverse]
    
    func changeColor(button: UIButton) {
        outputText.textColor = button.backgroundColor
    }

/*    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "colorSegue" {
            let viewController : ColorController = segue.destination as! ColorController
            print("데이터가 전달되었습니다.")
            viewController.delegate = self
        }
    }
 */
   
    
    override func viewDidLoad() {

        super.viewDidLoad()
        for button in colorButtons {
            button.layer.cornerRadius = button.frame.width/2
        }
        
        // Do any additional setup after loading the view.
    }


}

extension ViewController: colorDelegate {
    func sendColor(color: UIColor) {
        outputText.textColor = color
    }
}
