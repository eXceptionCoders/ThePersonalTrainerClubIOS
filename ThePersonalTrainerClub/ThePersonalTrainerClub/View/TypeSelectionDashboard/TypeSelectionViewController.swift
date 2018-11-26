//
//  TypeSelectionViewController.swift
//  ThePersonalTrainerClub
//
//  Created by VINACHES LOPEZ JORGE on 23/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import UIKit

class TypeSelectionViewController: BaseViewController, TypeSelectionContract.View {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var trainerImage: UIImageView!
    @IBOutlet weak var clientImage: UIImageView!
    
    lazy var presenter: TypeSelectionContract.Presenter = TypeSelectionViewPresenter(view: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let trainerTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        let clientTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))

        trainerImage.isUserInteractionEnabled = true
        trainerImage.addGestureRecognizer(trainerTapGestureRecognizer)
        clientImage.isUserInteractionEnabled = true
        clientImage.addGestureRecognizer(clientTapGestureRecognizer)
    }
    
    override func localizeView() {
        title = NSLocalizedString("type_selection_title", comment: "")
        titleLabel.text = NSLocalizedString("type_selection_title_label", comment: "")
    }

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
