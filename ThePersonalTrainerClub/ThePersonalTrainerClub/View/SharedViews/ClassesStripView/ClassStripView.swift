//
//  ClassStripView.swift
//  ThePersonalTrainerClub
//
//  Created by VINACHES LOPEZ JORGE on 30/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import UIKit

class ClassStripView: UIView, NibLoadableView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private enum Constants {
        static let height: CGFloat = 185
    }
    
    private let operationQueue = OperationQueue()
    
    // MARK: - Overrides
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    func allowSelection(_ allow: Bool) {
        collectionView.allowsSelection = allow
    }
    
    // MARK: - Properties
    
    var items: [ClassModel] {
        get { return _items }
        set {
            _items = newValue
            collectionView.reloadSections(IndexSet(integer: 0))
        }
    }
    
    var indexPathsForSelectedItems: [IndexPath]? {
        get {
            return collectionView.indexPathsForSelectedItems
        }
    }
    
    private var _items: [ClassModel] = []
    
    // MARK: - Methods
    
    func invalidateLayout() {
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    func selectFirst() {
        collectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: UICollectionView.ScrollPosition.top)
    }
    
    // MARK: - Overrides
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Register the cell
        collectionView.register(ClassStripCell.self)
        collectionView.allowsMultipleSelection = false
    }
    
    // MARK: - UICollectionViewDatasource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ClassStripCell", for: indexPath) as! ClassStripCell
        
        let model = items[indexPath.row]
        
        cell.sportNameLabel.text = "\(model.sport.name.prefix(1).capitalized)\(model.sport.name.dropFirst())"
        cell.locationLabel.text = model.location.description
        cell.dateLabel.text = String(model.duration)
        cell.registeredLabel.text = "\(model.registered ?? 0)/\(model.maxusers)"
        cell.priceLabel.text = "\(model.price)€"
        cell.trainerLabel.text = "\(model.instructor.name) \(model.instructor.lastname)"
        cell.deleteButton.setTitle(NSLocalizedString("cancel_button_title", comment: ""), for: .normal)
        cell.trainerTitleLabel.text = NSLocalizedString("trainer_title_label", comment: "")

        if let icon = model.sport.icon, !icon.isEmpty {
            let downloadOperation = ImageDownloader(urlString: icon, indexPath: indexPath) { success, indexPath, image, error in
                
                if (!success) {
                    return
                }
                
                DispatchQueue.main.async {
                    guard let path = indexPath, let cell = collectionView.cellForItem(at: path) else {
                        return
                    }
                    
                    (cell as! ClassStripCell).sportIcon.image = image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
                    cell.tintColor = UIColor.customOrange
                }
            }
            operationQueue.addOperation( downloadOperation )
        }
  
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let model = items[indexPath.row]
        
        let height = 185.0
        // let width = UIScreen.main.bounds.width
        let width = bounds.size.width
        return CGSize(width: width, height: CGFloat( height ))
    }
}
