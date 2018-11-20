//
//  RegisterViewController.swift
//  ThePersonalTrainerClub
//
//  Created by VINACHES LOPEZ JORGE on 08/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import UIKit

class RegisterViewController: BaseViewController, RegisterContract.View {
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var genderTextField: UISegmentedControl!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var trainerButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var trainerLabel: UILabel!
    
    lazy var presenter: RegisterContract.Presenter = RegisterViewPresenter(view: self, registerUseCase: RegisterUseCase(registerProvider: RegisterProvider(webService: WebService())))
    
    private var originY: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarTitle("GymUs")
        
        onViewTapped()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.onViewTapped))
        self.view.addGestureRecognizer(tap)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        onViewTapped()
        
        NotificationCenter.default.addObserver(self, selector: #selector(RegisterViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(RegisterViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func localizeView() {
        nameTextField.placeholder = NSLocalizedString("register_name_placeholder", comment: "")
        lastNameTextField.placeholder = NSLocalizedString("register_last_name_placeholder", comment: "")
        genderTextField.setTitle(NSLocalizedString("register_gender_male_title", comment: ""), forSegmentAt: 0)
        genderTextField.setTitle(NSLocalizedString("register_gender_female_title", comment: ""), forSegmentAt: 1)
        emailTextField.placeholder = NSLocalizedString("register_email_placeholder", comment: "")
        passwordTextField.placeholder = NSLocalizedString("register_password_placeholder", comment: "")
        trainerLabel.text = NSLocalizedString("register_trainer_label_text", comment: "")
        signupButton.setTitle(NSLocalizedString("register_sign_up_button", comment: ""), for: .normal)
    }
    
    func showLoading() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func hideLoading() {
        activityIndicator.stopAnimating()
    }
    
    @IBAction func isTrainerTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }

    @IBAction func signUp(_ sender: UIButton) {
        let gender = genderTextField.selectedSegmentIndex == 0 ? "male" : "female"
        
        presenter.onRegister(name: nameTextField.text ?? "", lastName: lastNameTextField.text ?? "", gender: gender, email: emailTextField.text ?? "", password: passwordTextField.text ?? "")
    }
    
    @objc func onViewTapped() {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        scrollView.isScrollEnabled = true
        var info = notification.userInfo
        let keyboardSize = (info?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        let contentInsets : UIEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize!.height+16, right: 0.0)
        
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        var info = notification.userInfo!
        let keyboardSize = (info[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        let contentInsets : UIEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: -(keyboardSize!.height+16), right: 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        view.endEditing(true)
        scrollView.isScrollEnabled = false
    }
}
