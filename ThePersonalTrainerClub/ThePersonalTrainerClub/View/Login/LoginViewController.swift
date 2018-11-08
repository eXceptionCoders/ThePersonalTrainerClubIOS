//
//  LoginViewController.swift
//  ThePersonalTrainerClub
//
//  Created by VINACHES LOPEZ JORGE on 06/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController, LoginContract.View {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    lazy var presenter: LoginContract.Presenter = LoginViewPresenter(view: self, loginUseCase: LoginUseCase(loginProvider: LoginProvider(webService: WebService())))
    
    func showLoading() {
        activityIndicator.startAnimating()
    }
    
    func hideLoading() {
        activityIndicator.stopAnimating()
    }
    
    func showMessage(_ message: String) {
        let alertVC = UIAlertController(title: "MENSAJE!", message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Vale", style: .default) { _ in
            alertVC.dismiss(animated: true, completion: nil)
        }
        alertVC.addAction(alertAction)
        self.present(alertVC, animated: true, completion: nil)
    }
    
    @IBAction func registerButtonAction(_ sender: Any) {
        presenter.onRegister()
    }
    
    @IBAction func loginButtonAction(_ sender: Any) {
        presenter.onLogin(email: emailTextField.text ?? "", password: passwordTextField.text ?? "")
    }
}
