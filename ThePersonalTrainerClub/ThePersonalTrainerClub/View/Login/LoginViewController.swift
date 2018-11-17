//
//  LoginViewController.swift
//  ThePersonalTrainerClub
//
//  Created by VINACHES LOPEZ JORGE on 06/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController, LoginContract.View {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    lazy var presenter: LoginContract.Presenter = LoginViewPresenter(view: self, loginUseCase: LoginUseCase(loginProvider: LoginProvider(webService: WebService())))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarTitle("GymUs")
        
        onViewTapped()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.onViewTapped))
        self.view.addGestureRecognizer(tap)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        onViewTapped()
        
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func showLoading() {
        activityIndicator.startAnimating()
    }
    
    func hideLoading() {
        activityIndicator.stopAnimating()
    }
    
    @IBAction func registerButtonAction(_ sender: Any) {
        presenter.onRegister()
    }
    
    @IBAction func loginButtonAction(_ sender: Any) {
        presenter.onLogin(email: emailTextField.text ?? "", password: passwordTextField.text ?? "")
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
