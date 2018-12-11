//
//  TypeSelectionViewController.swift
//  ThePersonalTrainerClub
//
//  Created by VINACHES LOPEZ JORGE on 23/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import UIKit

class TypeSelectionViewController: BaseViewController, TypeSelectionContract.View {

    // MARK: - Outlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var trainerImage: UIImageView!
    @IBOutlet weak var clientImage: UIImageView!
    
    // MARK: - Presenter
    
    lazy var presenter: TypeSelectionContract.Presenter = TypeSelectionViewPresenter(view: self)
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let trainerTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        let clientTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))

        if UserSettings.showCoachView {
            // trainerImage.image = noir(trainerImage.image!)
            trainerImage.alpha = 0.25
            
            clientImage.isUserInteractionEnabled = true
            clientImage.alpha = 1
            clientImage.addGestureRecognizer(clientTapGestureRecognizer)
            clientImage.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        } else {
            // clientImage.image = noir(clientImage.image!)
            clientImage.alpha = 0.25
            
            trainerImage.isUserInteractionEnabled = true
            trainerImage.alpha = 1
            trainerImage.addGestureRecognizer(trainerTapGestureRecognizer)
            trainerImage.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }
    }
    
    // MARK: - BaseViewController methods
    
    override func localizeView() {
        if UserSettings.showCoachView {
            title = String(format: NSLocalizedString("type_selection_title", comment: ""), NSLocalizedString("type_selection_athlete", comment: ""))
        } else {
            title = String(format: NSLocalizedString("type_selection_title", comment: ""), NSLocalizedString("type_selection_trainer", comment: ""))
        }
        
        titleLabel.text = NSLocalizedString("type_selection_title_label", comment: "")
    }

    // MARK: - Helpers
    
    func noir(_ image: UIImage) -> UIImage {
        let context = CIContext(options: nil)
        let currentFilter = CIFilter(name: "CIPhotoEffectNoir")
        currentFilter!.setValue(CIImage(image: image), forKey: kCIInputImageKey)
        let output = currentFilter!.outputImage
        let cgimg = context.createCGImage(output!,from: output!.extent)
        return UIImage(cgImage: cgimg!)
    }
    
    // MARK: - Actions
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        
        if tappedImage == trainerImage {
            presenter.onTypeSelected(type: TypeSelection.trainer)
        } else {
            presenter.onTypeSelected(type: TypeSelection.client)
        }
    }
}
