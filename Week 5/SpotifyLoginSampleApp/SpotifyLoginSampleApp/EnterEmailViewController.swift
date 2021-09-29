//
//  EnterEmailViewController.swift
//  SpotifyLoginSampleApp
//
//  Created by 이재웅 on 2021/09/10.
//

import UIKit
import FirebaseAuth

class EnterEmailViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextButton.layer.cornerRadius = 30
        
        // 이메일이랑 비밀번호가 입력 안되있을 경우 로그인버튼을 못누르게 설정
        nextButton.isEnabled = false
        
        // 파이어베이스 인증에 전달할 텍스트 값을 받으려면 텍스트필드에 입력된 값을 받아와야 하는데, 그러기 위해선 텍스트필드의 delegate 설정이 필요하다.
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        // 화면이 넘어왔을때, 입력 커서가 이메일 텍스트필드로 바로 가게 해줌
        emailTextField.becomeFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Navigation Bar 보이기
        navigationController?.navigationBar.isHidden = false
    }

    @IBAction func nextButtonTapped(_ sender: UIButton) {
        //Firebase 이메일/비밀번호 인증
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        //신규 사용자 생성
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else { return }
            
            // 같은 이메일로 로그인(이미 있는 이메일로 아이디를 만드려할 경우)을 방지하는 코드
            if let error = error{
                let code = (error as NSError).code
                switch code {
                case 17007: //이미 가입한 계정일 때
                    //로그인하기 - 우리는 creatUser함수를 사용했기 때문에 로그인이 아닌 계정생성 함수임. 따라서 여기에 로그인클로저를 이용할것
                    self.loginUser(withEmail: email, password: password)
                default: //기타 에러일경우, 에러의 디스크립션을 보여주자
                    self.errorMessageLabel.text = error.localizedDescription
                }
            } else { //에러가 없을경우
                self.showMainViewController()
            }
            
            
            // 로그인 됬을 경우 메인화면을 나타낼 것이다 >> error코드 작성하면서 그 위로 옮김. 여긴 필요없음
            // self.showMainViewController()
        }
    }
    
    // 정상적으로 인증이 완료되었을 경우, Main화면으로 넘어가야함. 코드를 깔끔히 해주기 위해서 여기에 작성
    private func showMainViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let mainViewController = storyboard.instantiateViewController(identifier: "MainViewController")
        mainViewController.modalPresentationStyle = .fullScreen
        navigationController?.show(mainViewController, sender: nil)
    }
    
    private func loginUser(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] _, error in
            guard let self = self else { return }
            
            if let error = error {
                self.errorMessageLabel.text = error.localizedDescription
            } else {
                self.showMainViewController()
            }
        }
    }
}

// extension으로 딜리게이트 설정을 해줄것임
extension EnterEmailViewController: UITextFieldDelegate {
    
    // 이메일, 비밀번호 입력이 끝나고 리턴버튼을 눌렀을때 키보드가 내려가게 할것
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)   // 입력이 끝나면?
        return false            // 내려줘라
    }
    
    // 이메일과 비밀번호에 입력되어 있는 값이 있는걸 확인하고 '다음' 버튼을 활성화시킬것
    func textFieldDidEndEditing(_ textField: UITextField) {
        let isEmailEmpty = emailTextField.text == ""                // 이메일 텍스트필드가 비어져있을경우
        let isPasswordEmpty = passwordTextField.text == ""          // 비밀번호 텍스트필드가 비어져있을경우
        nextButton.isEnabled = !isEmailEmpty && !isPasswordEmpty    // 이메일, 비밀번호 텍스트필드가 둘다 채워져있을경우 활성화
    }
}
