//
//  ActivityStripView.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 17/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import UIKit

class ActivityStripView: UIView, NibLoadableView, UICollectionViewDelegate,  UICollectionViewDataSource {

    private enum Constants {
        static let height: CGFloat = 80
    }
    
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - Properties
    
    var items: [ActivityModel] {
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
    
    private var _items: [ActivityModel] = []
    private var _preselectedItems: [ActivityModel] = []
    private let operationQueue = OperationQueue()

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
        collectionView.register(ActivityStripCell.self)
        collectionView.allowsMultipleSelection = false
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if (!_preselectedItems.isEmpty) {
            for preselected in _preselectedItems {
                //TODO: Cambiar name por id
                if let i = items.firstIndex(where: {$0.name == preselected.name}) {
                    collectionView.selectItem(at: IndexPath(row: i, section: 0), animated: false, scrollPosition: .top)
                }
            }

        }
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: Constants.height)
    }
    
    func allowSelection(_ allow: Bool) {
        collectionView.allowsSelection = allow
    }
    
    func setSelectedItems(items: [ActivityModel]) {
        _preselectedItems = items
    }
    
    func allowsMultipleSelection(_ allows: Bool) {
        collectionView.allowsMultipleSelection = allows
    }
    
    // MARK: - UICollectionViewDatasource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActivityStripCell", for: indexPath) as! ActivityStripCell
        
        let model = items[indexPath.row]
        cell.label.text = model.name
        
        let downloadOperation = ImageDownloader(urlString: model.icon!, indexPath: indexPath) { success, indexPath, image, error in
            
            if (!success) {
                return
            }
            
            DispatchQueue.main.async {
                guard let path = indexPath, let cell = collectionView.cellForItem(at: path) else {
                    return
                }
                
                (cell as! ActivityStripCell).imageView.image = image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
                cell.tintColor = UIColor.customOrange
            }
        }
        operationQueue.addOperation( downloadOperation )

        return cell
    }
}
