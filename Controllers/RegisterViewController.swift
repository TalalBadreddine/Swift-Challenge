//
//  RegisterViewController.swift
//  Swift-Challenge
//
//  Created by Talal Badreddine on 29/11/2021.
//

import UIKit
import PhotosUI
import Firebase

class RegisterViewController: UIViewController {
        
    let datePicker = UIDatePicker()
    
    // MARK: UIProperties
    
    private let scrollView:UIScrollView = {
        
        let scroll = UIScrollView()
        scroll.clipsToBounds = true
        
        return scroll
    }()
    
    private var userImage:UIImageView = {
        
        let image = UIImageView()
        image.image = UIImage(systemName: "person")
        image.layer.borderWidth = 2
        image.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        image.layer.masksToBounds = true
        image.tintColor = .black
        
        return image
    }()
    
    private var userEmailTextField:UITextField = {
        
        let username = UITextField()
        username.layer.borderWidth = 2
        username.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0.8)
        username.layer.cornerRadius = 12
        username.autocorrectionType = .no
        username.autocapitalizationType = .none
        username.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        username.leftViewMode = .always
        username.placeholder = "Email"
        username.textContentType = .emailAddress
        
        return username
    }()
    
    private var userEmailValidationLabel: UILabel = {
        
        let label = UILabel()
        label.isHidden = true
        label.font = label.font.withSize(12)
        label.textColor = .red
        
        return label
    }()
    
    private var birthDate : UITextField = {
        
        let date = UITextField()
        date.layer.borderWidth = 2
        date.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0.8)
        date.layer.cornerRadius = 12
        date.autocorrectionType = .no
        date.autocapitalizationType = .none
        date.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        date.leftViewMode = .always
        date.placeholder = "Age"
        date.addTarget(self, action: #selector(setDate), for: .touchUpInside)
        
        return date
        }()
    
    private var birthDateValidationLabel: UILabel = {
        
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
    
    private var registerButton:UIButton = {
        
       let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.backgroundColor = .systemRed
        button.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0.8)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.layer.cornerRadius = 12
        
       return button
    }()
    
    // MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // initialize textFields delegates
        initialize()
        
        // Needed To Help the uiLabel for date
        
        setDate()
        
        // In case User quit the app while setting up date
        
        enableEverything(is: true)
        
        // Image can Be clicked
        
        let userImageTapGesture = UITapGestureRecognizer(target: self,
                                                         action: #selector(userImageTapped)
                                                         )
        
        userImage.addGestureRecognizer(userImageTapGesture)
        userImage.isUserInteractionEnabled = true
        
        // Eye image can be tapped
        
        let eyeImageTapGesture = UITapGestureRecognizer(target: self,
                                                        action: #selector(eyeImageTapped)
                                                        )
        
        eyeImage.addGestureRecognizer(eyeImageTapGesture)
        eyeImage.isUserInteractionEnabled = true
        
        // Return to login screen
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeButtonSelected))
        
        registerButton.isUserInteractionEnabled = true
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        
        view.backgroundColor = .white
        
        // adding UI component
        view.addSubview(scrollView)
        scrollView.addSubview(userImage)
        scrollView.addSubview(userEmailTextField)
        scrollView.addSubview(passwordTextField)
        passwordTextField.addSubview(eyeImage)
        scrollView.addSubview(birthDate)
        scrollView.addSubview(registerButton)
        scrollView.addSubview(userEmailValidationLabel)
        scrollView.addSubview(passwordValidationLabel)
        scrollView.addSubview(birthDateValidationLabel)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        updateUI()
        
    }
    
    //MARK: UIFrames
    
    func updateUI(){
        
        scrollView.frame = view.frame
        
        userImage.frame = CGRect(x: view.width/2 - view.width/4 ,
                                 y: 20, width: view.width/2  ,
                                 height: view.width/2
                                 )
        
        userImage.layer.cornerRadius = userImage.width/2
        
        userEmailTextField.frame = CGRect(x:20 ,
                                          y: userImage.bottom + 80,
                                          width: view.width - 40 ,
                                          height: 40
                                          )
        
        userEmailValidationLabel.frame = CGRect(x: userEmailTextField.left,
                                                y: userEmailTextField.bottom + 5,
                                                width: userEmailTextField.width,
                                                height: 13
                                                )
        
        birthDate.frame = CGRect(x:userEmailTextField.left ,
                                         y: userEmailValidationLabel.bottom + 15,
                                         width: userEmailTextField.width ,
                                         height: userEmailTextField.heigth
                                         )
        
       birthDateValidationLabel.frame = CGRect(x: birthDate.left,
                                               y: birthDate.bottom + 5,
                                                width: userEmailTextField.width,
                                               height: userEmailValidationLabel.heigth
                                                )
        
        passwordTextField.frame = CGRect(x:birthDate.left ,
                                         y: birthDateValidationLabel.bottom + 15,
                                         width: birthDate.width ,
                                         height: birthDate.heigth
                                         )
        
        passwordValidationLabel.frame = CGRect(x: passwordTextField.left,
                                               y: passwordTextField.bottom + 5,
                                               width: passwordTextField.width,
                                                 height: userEmailValidationLabel.heigth
                                                 )
        
        eyeImage.frame = CGRect(x: passwordTextField.right - 45 ,
                                y: passwordTextField.heigth/2 - 10,
                                width: 20,
                                height: 20
                                )
        
        registerButton.frame = CGRect(x:view.width/2 - passwordTextField.width/4,
                                         y: passwordTextField.bottom + 20,
                                         width: passwordTextField.width/2 ,
                                         height: passwordTextField.heigth + 10
                                         )
    }
    
//MARK: Handlers
    //TODO: Find a Way to change data formatter position in toolbar.
    @objc func setDate(){
        
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done,
                                         target: self,
                                         action: #selector(doneButtonPressed)
                                         )
        
        toolbar.setItems([doneButton], animated: true)
        
       
        
        birthDate.inputAccessoryView = toolbar
        
        birthDate.inputView = datePicker
        
        datePicker.datePickerMode = .date
    }
    
    @objc func doneButtonPressed(){
        enableEverything(is: true)
        
        let formatter = DateFormatter()
        //Setting time withou the days (meduim),(full = with days)
        formatter.dateStyle = .medium
        //Unable Time Format(Hours//Min//Seconds)
        formatter.timeStyle = .none
        
        birthDate.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
        
    }
    
   @objc func userImageTapped() {
       
       var configuration = PHPickerConfiguration()
       configuration.filter = .images
       configuration.preferredAssetRepresentationMode = .current
       let picker = PHPickerViewController(configuration: configuration)
       picker.delegate = self
       
       navigationController?.present(picker, animated: true, completion: nil)
        
    }
    
    @objc func enableEverything(is value:Bool){
        // Disable everything when birthdate is selected

        userEmailTextField.isEnabled = value
        userImage.isUserInteractionEnabled = value
        registerButton.isEnabled = value
        passwordTextField.isEnabled = value
        
    }
    
    @objc func closeButtonSelected(){
        dismiss(animated: true, completion: nil)
    }
    
    // Change password visisbility
    @objc func eyeImageTapped() {
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
    
    @objc func registerButtonTapped(){
        
        validatingUserInfo()
        
    }
    
    // Getting the age from calender
   // TODO: Review the function !!!
    func age() -> Int {
        return Int(Calendar.current.dateComponents([.year], from: datePicker.date, to: Date()).year!)
    }
    
    // handling errors
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
    
    // MARK: Validate User Infos
    
    func validatingUserInfo() {
        
        // TODO: Remember Dry!!! Need to find a easier way to modifie the errors
        
        guard let email = userEmailTextField.text , !email.isEmpty else{
            handlingErrors(in: userEmailTextField, error: "Email Field Empty", validation: userEmailValidationLabel)
            return
        }

        guard email.isValidEmail else{
            handlingErrors(in: userEmailTextField, error: "Invalid Email", validation: userEmailValidationLabel)
            return
        }

        guard let dateOfBirth = birthDate.text , !dateOfBirth.isEmpty else {
            handlingErrors(in: birthDate, error: "Age Not Found !", validation: birthDateValidationLabel)
            return
        }

        guard age() > 4, age() < 110 else {
            handlingErrors(in: birthDate, error: "Age is not Accurant", validation: birthDateValidationLabel)
            return
        }

        guard age() > 18, age() < 99 else {
            handlingErrors(in: birthDate, error: "Age Must be between 18 and 99", validation: birthDateValidationLabel)
            return
        }

        guard let password = passwordTextField.text , !password.isEmpty else {
            handlingErrors(in: passwordTextField, error: "Password Field Is Empty!", validation: passwordValidationLabel)
            return
        }
        
        guard password.count > 6 else {
            handlingErrors(in: passwordTextField, error: "Password Is Short", validation: passwordValidationLabel)
            return
        }

        guard password.count < 12 else {
            handlingErrors(in: passwordTextField, error: "Password too long", validation: passwordValidationLabel)
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) {[weak self] results, error in
            
            guard let strongSelf = self else {
                return
            }
                
            guard results != nil , error == nil else{
                strongSelf.showMessagePrompt(error!.localizedDescription)
                return
            }
            
            strongSelf.showMessagePrompt("User Created \(email.self)")
        
        }
    }
}

// MARK: Continue Validating with firebase
func firebaseValidation(){
    

    
}

// MARK: imagePicker
// TODO: Add The userImage functionality
extension RegisterViewController:UINavigationControllerDelegate, UIImagePickerControllerDelegate, PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        print("sado")
    }
}

// MARK: textFieldDelegate + Selection of TextField
extension RegisterViewController: UITextFieldDelegate {
    
    func initialize(){
        userEmailTextField.delegate = self
        passwordTextField.delegate = self
        birthDate.delegate = self
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == birthDate {
            enableEverything(is: false)
            returnToNomal(birthDate, birthDateValidationLabel)
            
        } else if textField == userEmailTextField {
            returnToNomal(userEmailTextField, userEmailValidationLabel)
            
        } else if textField == passwordTextField {
            returnToNomal(passwordTextField, passwordValidationLabel)
            
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case userEmailTextField:
            birthDate.becomeFirstResponder()
        case birthDate:
            passwordTextField.becomeFirstResponder()
        default:
            userEmailTextField.resignFirstResponder()
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

