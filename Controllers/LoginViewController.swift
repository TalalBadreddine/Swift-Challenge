//
//  LoginViewController.swift
//  Swift-Challenge
//
//  Created by Talal Badreddine on 29/11/2021.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    // MARK: UIProperties
    private let scrollView:UIScrollView = {
        
        let scroll = UIScrollView()
        scroll.clipsToBounds = true
        
        return scroll
    }()
    
    private var mainImage:UIImageView = {
        
        let image = UIImageView()
        image.image = UIImage(systemName: "infinity")
        image.tintColor = .black
        
        return image
    }()
    
    private var emailTextField:UITextField = {
        
        let email = UITextField()
        email.layer.borderWidth = 2
        email.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0.8)
        email.layer.cornerRadius = 12
        email.autocorrectionType = .no
        email.autocapitalizationType = .none
        email.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        email.leftViewMode = .always
        email.placeholder = "Email"
        email.textContentType = .emailAddress
        
        return email
    }()
    
    private var emailValidationLabel: UILabel = {
        
        let label = UILabel()
        label.isHidden = true
        label.font = label.font.withSize(12)
        label.textColor = .red
        
        return label
    }()
    
    private var passwordTextField:UITextField = {
        
        let password = UITextField()
        password.layer.borderWidth = 2
        password.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0.8)
        password.layer.cornerRadius = 12
        password.autocorrectionType = .no
        password.autocapitalizationType = .none
        password.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        password.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 22, height: 0))
        password.rightViewMode = .always
        password.leftViewMode = .always
        password.placeholder = "Password"
        password.isSecureTextEntry = true
        
        return password
    }()
    
    private var passwordValidationLabel: UILabel = {
        
        let label = UILabel()
        label.isHidden = true
        label.font = label.font.withSize(12)
        label.textColor = .red
        
        return label
    }()
    
    private var eyeImage:UIImageView = {
        
        let image = UIImageView()
        image.image = UIImage(systemName: "eye.fill")
        image.tintColor = .black
        return image
    }()
    
    private var loginButton:UIButton = {
        
       let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.backgroundColor = .systemGreen
        button.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0.8)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.layer.cornerRadius = 12
        
       return button
    }()
    
    private var orLabel:UILabel = {
        
       let label = UILabel()
        label.font = .systemFont(ofSize: 15 , weight: .bold)
        label.text = "Or"
        
       return label
    }()
    
    private var registerButton:UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.tintColor = .white
        button.backgroundColor =  .black
        button.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0.8)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: ViewDiDLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        initialize()
        
        // Login Button
        loginButton.isUserInteractionEnabled = true
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
        // eye Image
        let eyeImageTappedGesture = UITapGestureRecognizer(target: self,
                                                        action: #selector(eyeImageTapped)
                                                        )
        eyeImage.addGestureRecognizer(eyeImageTappedGesture)
        eyeImage.isUserInteractionEnabled = true
        
        view.addSubview(scrollView)
        scrollView.addSubview(mainImage)
        scrollView.addSubview(emailTextField)
        scrollView.addSubview(passwordTextField)
        scrollView.addSubview(loginButton)
        scrollView.addSubview(orLabel)
        scrollView.addSubview(registerButton)
        scrollView.addSubview(emailValidationLabel)
        scrollView.addSubview(passwordValidationLabel)
        passwordTextField.addSubview(eyeImage)
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        updatingUI()
    }
    
    // MARK: UIFrames
    func updatingUI(){
        
        scrollView.frame = view.frame
        
        mainImage.frame = CGRect(x: view.width/4 - view.width/6,
                                 y: 25,
                                 width: view.width/2 + view.width/3,
                                 height: view.width/2
                                 )
        
        emailTextField.frame = CGRect(x:20 ,
                                         y: mainImage.bottom + 70,
                                         width: view.width - 40 ,
                                         height: 40
                                         )
        emailValidationLabel.frame = CGRect(x:emailTextField.left ,
                                            y: emailTextField.bottom + 5,
                                            width: emailTextField.width ,
                                            height: 13
                                            )
        
        passwordTextField.frame = CGRect(x:emailTextField.left ,
                                         y: emailValidationLabel.bottom + 15,
                                         width: emailTextField.width ,
                                         height: emailTextField.heigth
                                         )
        
        passwordValidationLabel.frame = CGRect(x:emailTextField.left ,
                                            y: passwordTextField.bottom + 5,
                                            width: emailTextField.width ,
                                            height: 13
                                            )
        
        eyeImage.frame = CGRect(x: passwordTextField.right - 45 ,
                                y: passwordTextField.heigth/2 - 10,
                                width: 20,
                                height: 20
                                )
        
        loginButton.frame = CGRect(x: view.width/2 - passwordTextField.width/4,
                                   y: passwordTextField.bottom + 25,
                                   width: passwordTextField.width/2,
                                   height: passwordTextField.heigth + 10
                                   )
        
        orLabel.frame = CGRect(x: CGFloat(loginButton.left + loginButton.width/2 - 7.5) ,
                               y: loginButton.bottom + 12,
                               width: 30 ,
                               height: 13
                                )
        
        registerButton.frame = CGRect(x: loginButton.left,
                                      y: orLabel.bottom + 10,
                                      width: loginButton.width,
                                      height: loginButton.heigth
                                      )
    }
    
    // MARK: Handlers
    
    @objc func registerButtonTapped(){
        
        let vc = UINavigationController(rootViewController: RegisterViewController() )
        vc.modalPresentationStyle = .fullScreen
        present(vc,animated: true)
        
    }
    
    @objc func loginButtonTapped(){
        
        validateUserInfos()
        
    }
    
    @objc func eyeImageTapped(){
        passwordTextField.isSecureTextEntry.toggle()
        if passwordTextField.isSecureTextEntry {
            if let image = UIImage(systemName: "eye.fill") {
                eyeImage.image = image
            }
        } else {
            if let image = UIImage(systemName: "eye.slash.fill") {
                eyeImage.image = image
            }
        }
    }
    
    func handlingErrors(in textField: UITextField, error:String , validation: UILabel){
        
        textField.adjustsFontSizeToFitWidth = true
        textField.layer.borderColor = .init(red: 255, green: 0, blue: 0, alpha: 1)
        textField.blink()
        validation.isHidden = false
        validation.text = error
        validation.textColor = .init(red: 255, green: 0, blue: 0, alpha: 1)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.returnToNomal(textField, validation)
        }
        
    }
    
    // MARK: Validating User Info
    func validateUserInfos(){
        guard let email = emailTextField.text , !email.isEmpty else {
            handlingErrors(in: emailTextField, error: "Email Empty", validation: emailValidationLabel)
            return
        }
        
        guard email.isValidEmail else{
            handlingErrors(in: emailTextField, error: "Email not valid", validation: emailValidationLabel)
            return
        }
        
        guard let password = passwordTextField.text , !password.isEmpty else {
            handlingErrors(in: passwordTextField, error: "Password Empty", validation: passwordValidationLabel)
            return
        }
        
        guard password.count < 12 else {
            handlingErrors(in: passwordTextField, error: "Passwor too long", validation: passwordValidationLabel)
            return
        }
        
        guard password.count > 6 else {
            handlingErrors(in: passwordTextField, error: "Passwor too short", validation: passwordValidationLabel)
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) {[weak self] results, error in
            guard let strongSelf = self else {
                return
            }
            
            guard results != nil , error == nil else{
                strongSelf.showMessagePrompt(error!.localizedDescription)
                return
            }
            
            strongSelf.showMessagePrompt("Login In Successfully")
            
            let vc = ViewController()
            vc.modalPresentationStyle = .fullScreen
            self?.present(vc,animated: true)
        }
    }
}

// MARK: textFieldDelegate + Selection of TextField
extension LoginViewController: UITextFieldDelegate {
    
    func initialize(){
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == emailTextField {
            returnToNomal(emailTextField, emailValidationLabel)
            
        } else {
            returnToNomal(passwordTextField, passwordValidationLabel)
            
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailTextField:
            passwordTextField.becomeFirstResponder()
        default:
            passwordTextField.becomeFirstResponder()
        }
        return true
    }
    
    func returnToNomal(_ textField: UITextField ,_ label: UILabel) {
        textField.layer.removeAllAnimations()
        textField.layer.removeAllAnimations()
        textField.layoutIfNeeded()
        textField.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0.8)
        label.isHidden = true
    }
}
