//
//  ClassStripView.swift
//  ThePersonalTrainerClub
//
//  Created by VINACHES LOPEZ JORGE on 30/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import UIKit

protocol ClassStripViewDelegate: class {
    // should, will, did
    func classStripViewDelegate (_ view: ClassStripView, didSelectClass: ClassModel)
    
    func classStripViewDelegate (_ view: ClassStripView, didCancelClass: ClassModel)
    
    func classStripViewDelegate (_ view: ClassStripView, didBookClass: ClassModel)
}

class ClassStripView: UIView, NibLoadableView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    public enum Constants {
        static let height: CGFloat = 185
    }
    
    private let operationQueue = OperationQueue()
    @IBOutlet weak var withoutClassesLabel: UILabel!
    
    // MARK: - Overrides
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    func allowSelection(_ allow: Bool) {
        collectionView.allowsSelection = allow
    }
    
    // MARK: - Delegates
    
    weak var delegate: ClassStripViewDelegate?
    
    // MARK: - Properties
    
    private var _showWithoutClassesLabel = false
    var showWithoutClassesLabel: Bool {
        get { return _showWithoutClassesLabel }
        set {
            _showWithoutClassesLabel = newValue
        }
    }
    
    private var _withoutClassesLabelForTrainer = false
    var withoutClassesLabelForTrainer: Bool {
        get { return _withoutClassesLabelForTrainer }
        set {
            _withoutClassesLabelForTrainer = newValue
            
            withoutClassesLabel.text = newValue
                ? NSLocalizedString("without_trainer_classes_label", comment: "")
                : NSLocalizedString("without_athlete_classes_label", comment: "")
        }
    }
    
    var items: [ClassModel] {
        get { return _items }
        set {
            _items = newValue
            
            withoutClassesLabel.isHidden = !showWithoutClassesLabel || newValue.count > 0
            
            collectionView.reloadSections(IndexSet(integer: 0))
        }
    }
    
    var showBookingButton: Bool {
        get { return _showBookingButton }
        set {
            _showBookingButton = newValue
        }
    }
    
    var indexPathsForSelectedItems: [IndexPath]? {
        get {
            return collectionView.indexPathsForSelectedItems
        }
    }
    
    private var _items: [ClassModel] = []
    private var _showBookingButton = false
    
    // MARK: - Methods
    
    func invalidateLayout() {
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    func selectFirst() {
        selectItemAt(0)
    }
    
    func selectItemAt(_ row: Int) {
        let numOfItems = collectionView.numberOfItems(inSection: 0)
        
        if numOfItems == 0 {
            return
        }
        
        collectionView.selectItem(at: IndexPath(row: min(row, numOfItems - 1), section: 0), animated: false, scrollPosition: UICollectionView.ScrollPosition.top)
    }
    
    // MARK: - Overrides
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Register the cell
        collectionView.register(ClassStripCell.self)
        collectionView.allowsMultipleSelection = false
        
        withoutClassesLabel.text = withoutClassesLabelForTrainer
            ? NSLocalizedString("without_trainer_classes_label", comment: "")
            : NSLocalizedString("without_athlete_classes_label", comment: "")
    }
    
    // MARK: - UICollectionViewDatasource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ClassStripCell", for: indexPath) as! ClassStripCell
        
        let row = indexPath.row
        let model = items[row]
        
        cell.model = model
        cell.sportNameLabel.text = "\(model.sport.name.prefix(1).capitalized)\(model.sport.name.dropFirst())"
        cell.locationLabel.text = model.location.description
        cell.dateLabel.text = String(model.duration)
        cell.registeredLabel.text = "\(model.registered ?? 0)/\(model.maxusers)"
        cell.priceLabel.text = "\(model.price) €"
        cell.trainerLabel.text = "\(model.instructor.name) \(model.instructor.lastname)"
        cell.deleteButton.setTitle( !showBookingButton
            ? NSLocalizedString("cancel_button_title", comment: "")
            : NSLocalizedString("booking_button_title", comment: "")
            , for: .normal)
        cell.trainerTitleLabel.text = NSLocalizedString("trainer_title_label", comment: "")
  
        cell.deleteButton.addTarget(self, action: #selector(onCellButtonClick), for: .touchUpInside)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let model = items[indexPath.row]
        
        if let icon = model.sport.icon {
            if !icon.isEmpty {
                let downloadOperation = ImageDownloader(urlString: icon, indexPath: indexPath) { success, indexPath, image, error in
                    
                    if (!success) {
                        return
                    }
                    
                    DispatchQueue.main.async {
                        guard let path = indexPath else {
                            return
                        }
                        
                        guard let cell = collectionView.cellForItem(at: path) else {
                            return
                        }
                        
                        (cell as! ClassStripCell).sportIcon.image = image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
                        cell.tintColor = UIColor.customOrange
                    }
                }
                operationQueue.addOperation( downloadOperation )
            }
        }
        
        if !model.instructor.thumbnail.isEmpty {
            let downloadOperation = ImageDownloader(urlString: model.instructor.thumbnail, indexPath: indexPath) { success, indexPath, image, error in
                
                if (!success) {
                    return
                }
                
                DispatchQueue.main.async {
                    guard let path = indexPath else {
                        return
                    }
                    
                    guard let cell = collectionView.cellForItem(at: path) else {
                        return
                    }
                    
                    (cell as! ClassStripCell).thumbnailImageView.image = image
                }
            }
            operationQueue.addOperation( downloadOperation )
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = items[indexPath.row]
        
        delegate?.classStripViewDelegate(self, didSelectClass: model)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // let model = items[indexPath.row]
        
        let height = 185.0
        // let width = UIScreen.main.bounds.width
        let width = bounds.size.width
        return CGSize(width: width, height: CGFloat( height ))
    }
    
    @objc func onCellButtonClick(sender: UIButton!) {
        guard let cell = sender.superview?.superview?.superview as? ClassStripCell, let model = cell.model else {
            return
        }
        
        if showBookingButton {
            delegate?.classStripViewDelegate(self, didBookClass: model)
        } else {
            delegate?.classStripViewDelegate(self, didCancelClass: model)
        }
    }
}
