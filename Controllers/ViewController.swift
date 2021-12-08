//
//  ViewController.swift
//  Swift-Challenge
//
//  Created by Talal Badreddine on 26/11/2021.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    private let logoutButton:UIButton = {
        
       let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Logout from \(String(describing: Auth.auth().currentUser))", for: .normal)
        button.setTitleColor(.red, for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        
        logoutButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
        
        view.addSubview(logoutButton)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if FireBaseManager().userIsLoggedIn() {
            print("user is logged in")
            
        }else{
            
                let vc = UINavigationController(rootViewController: LoginViewController())
                vc.modalPresentationStyle = .fullScreen
                present(vc,animated: false)
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        logoutButton.frame = CGRect(x: 20,
                                    y: 20,
                                    width: 150,
                                    height: 100
                                    )
    }
    
    @objc func logout(){
        
        do { try Auth.auth().signOut() }
        catch { self.showMessagePrompt("already logged out") }
        
        let vc = LoginViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc,animated: true)
        
    }
}

