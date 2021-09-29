//
//  MainViewController.swift
//  SpotifyLoginSampleApp
//
//  Created by 이재웅 on 2021/09/10.
//

import UIKit
import FirebaseAuth

class MainViewController: UIViewController {
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var resetPasswordButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 팝 제스쳐를 막기 위함(뒤로가기 스와이프)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
        
        // Firebase를 통해 고객의 이메일을 가져올 수 있음. 없다면 고객으로 표현
        let email = Auth.auth().currentUser?.email ?? "고객"
        
        welcomeLabel.text = """
        환영합니다.
        \(email)님
        """
        
        //현재 유저의 provider데이터의 providerID가 패스워드를 통해 emailSignIn인지 아닌지 판별
        let isEmailSignIn = Auth.auth().currentUser?.providerData[0].providerID == "password"
        resetPasswordButton.isHidden = !isEmailSignIn   // emailSignIn이 아니라면(이메일로그인의 비밀번호가 아니라면) 숨겨짐
    }
    
    
    @IBAction func logoutButtonTapped(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
        
        do {
            try firebaseAuth.signOut()
            self.navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("ERROR: signout \(signOutError.localizedDescription)")
        }
        // 버튼을 누를경우 첫화면으로 넘어가게 됨(오류가 안날경우 실행되도록 위의 try문으로 넘어가자)
        //self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func resetPasswordButtonTapped(_ sender: UIButton) {
        // 현재 사용자가 가지고 있는 이메일로 비밀번호를 리셋할 수 있는 메일을 보내게 됨
        let email = Auth.auth().currentUser?.email ?? ""
        Auth.auth().sendPasswordReset(withEmail: email, completion: nil)
    }
    
    @IBAction func profilUpdateButtonTapped(_ sender: UIButton) {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = "재웅"
        changeRequest?.commitChanges { _ in
            let displayName = Auth.auth().currentUser?.displayName ?? Auth.auth().currentUser?.email ?? "고객"
            self.welcomeLabel.text = """
                환영합니다.
                \(displayName)님
                """
        }
        
    }
    
}
