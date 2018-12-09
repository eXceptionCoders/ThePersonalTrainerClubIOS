//
//  UserSettingsViewController.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 25/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import UIKit

class UserSettingsViewController: BaseViewController, UserSettingsContract.View {

    // MARK: - Outlets
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var roleLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var changeThumbnailButton: DefaultButton!
    @IBOutlet weak var logoutButton: DefaultButton!
    
    // MARK: - Presenter
    
    lazy var presenter: UserSettingsContract.Presenter = UserSettingsViewPresenter(
        view: self,
        trainerManagementUseCase: TrainerManagementUseCase(
            userProvider: UserProvider(webService: WebService()),
            classProvider: ClassProvider(webService: WebService())
        )
    )
    
    // MARK: - Properties
    
    private let operationQueue = OperationQueue()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideLoading()
        thumbnailImageView.setupAsUserThumbnail()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.fetchUser()
    }
    
    // MARK: - BaseViewController methods
    
    override func localizeView() {
        title = NSLocalizedString("user_settings_title", comment: "")
        
        if (UserSettings.user?.coach ?? false) && UserSettings.showCoachView {
            //Trainer
            roleLabel.text = NSLocalizedString("trainer_management_trainer_label", comment: "")
        } else {
            //Athlete
            roleLabel.text = NSLocalizedString("athlete_management_trainer_label", comment: "")
        }
    }
    
    override func showLoading() {
        activityIndicator.startAnimating()
        changeThumbnailButton.isUserInteractionEnabled = false
    }
    
    override func hideLoading() {
        activityIndicator.stopAnimating()
        changeThumbnailButton.isUserInteractionEnabled = true
    }
    
    // MARK: - UserSettingsContract.View
    
    func setUser(_ user: UserModel) {
        userNameLabel.text = "\(user.name) \(user.lastName)"
        // thumbnailImageView.image = UIImage(named: "UserMale")
        
        // operationQueue.cancelAllOperations()
        
        if !user.thumbnail.isEmpty {
            let downloadOperation = ImageDownloader(urlString: user.thumbnail, indexPath: nil) { success, indexPath, image, error in
                
                if (!success) {
                    return
                }
                
                DispatchQueue.main.async {
                    self.thumbnailImageView.image = image
                }
            }
            operationQueue.addOperation( downloadOperation )
        }
    }
    
    // MARK: - Actions
    
    @IBAction func logout(_ sender: Any) {
        presenter.onLogout()
    }
    
    @IBAction func changeThumbnail(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.modalPresentationStyle = .currentContext
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
        
    }
}

extension UserSettingsViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            presenter.setThumbnail(image)
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
}
