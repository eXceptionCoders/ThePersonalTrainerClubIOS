//
//  ClassDetailViewController.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 06/12/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import UIKit

class ClassDetailViewController: BaseViewController, ClassDetailContract.View {
    // MARK: - Outlets
    
    @IBOutlet weak var trainerLabel: UILabel!
    @IBOutlet weak var trainerNameLabel: UILabel!
    @IBOutlet weak var trainerImageView: UIImageView!
    
    @IBOutlet weak var activityLabel: UILabel!
    @IBOutlet weak var activityImageView: UIImageView!
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var usersLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var bookButton: DefaultButton!
    
    // MARK: - Properties
    
    // MARK: - Presenter
    
    lazy var presenter: ClassDetailContract.Presenter = ClassDetailViewPresenter()
    
    // MARK: - Properties
    
    var model: ClassModel!
    private let operationQueue = OperationQueue()
    
    // MARK: - Initialization
    
    init(model: ClassModel) {
        self.model = model
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        trainerImageView.setupAsUserThumbnail()
        
        activityLabel.text = "\(model.sport.name.prefix(1).capitalized)\(model.sport.name.dropFirst())"
        locationLabel.text = model.location.description
        timeLabel.text = String(model.duration)
        usersLabel.text = "\(model.registered ?? 0)/\(model.maxusers)"
        priceLabel.text = "\(model.price) €"
        
        trainerNameLabel.text = "\(model.instructor.name) \(model.instructor.lastname)"
        
        descriptionTextView.text = model.description
        
        if let icon = model.sport.icon {
            if !icon.isEmpty {
                let downloadIcon = ImageDownloader(urlString: icon, indexPath: nil) { success, indexPath, image, error in
                    if (!success) {
                        return
                    }
                    
                    DispatchQueue.main.async {
                        self.activityImageView.image = image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
                        self.activityImageView.tintColor = UIColor.customOrange
                    }
                }
                
                operationQueue.addOperation( downloadIcon )
            }
        }
        
        if !model.instructor.thumbnail.isEmpty {
            let downloadThumbnail = ImageDownloader(urlString: model.instructor.thumbnail, indexPath: nil) { success, indexPath, image, error in
                if (!success) {
                    return
                }
                
                DispatchQueue.main.async {
                    self.trainerImageView.image = image
                }
            }
            
            operationQueue.addOperation(downloadThumbnail)
        }
    }
    
    // MARK: - BaseViewController methods
    
    override func localizeView() {
        title = NSLocalizedString("class_detail_title", comment: "")
        trainerLabel.text = NSLocalizedString("class_detail_trainer_laabel", comment: "")
        bookButton.setTitle( NSLocalizedString("booking_button_title", comment: ""), for: .normal)
    }

    // MARK: - ClassDetailContract.View methods
    
    // MARK: - Actions
}
