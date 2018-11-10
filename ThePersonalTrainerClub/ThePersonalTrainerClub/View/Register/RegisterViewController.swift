//
//  RegisterViewController.swift
//  ThePersonalTrainerClub
//
//  Created by VINACHES LOPEZ JORGE on 08/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import UIKit

class RegisterViewController: BaseViewController, RegisterContract.View {

    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var genderTextField: UISegmentedControl!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var trainerButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    lazy var presenter: RegisterContract.Presenter = RegisterViewPresenter(view: self, registerUseCase: RegisterUseCase(registerProvider: RegisterProvider(webService: WebService())))
    
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
}
