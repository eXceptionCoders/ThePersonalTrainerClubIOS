//
//  ActivityStripView.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 17/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import UIKit

protocol ActivityStripViewDelegate {
    func activityStripViewDelegate (_ view: ActivityStripView, didSelectActivity: ActivityModel)
}

class ActivityStripView: UIView, NibLoadableView, UICollectionViewDelegate,  UICollectionViewDataSource {

    private enum Constants {
        static let height: CGFloat = 80
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var withoutActivitiesLabel: UILabel!
    
    // MARK: - Properties

    private var _items: [ActivityModel] = []
    var items: [ActivityModel] {
        get { return _items }
        set {
            _items = newValue
            
            withoutActivitiesLabel.isHidden = newValue.count > 0
            
            collectionView.reloadSections(IndexSet(integer: 0))
        }
    }
    
    var indexPathsForSelectedItems: [IndexPath]? {
        get {
            return collectionView.indexPathsForSelectedItems
        }
    }
    
    var delegate: ActivityStripViewDelegate?
    
    private var _preselectedItems: [ActivityModel] = []
    private let operationQueue = OperationQueue()

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
        collectionView.register(ActivityStripCell.self)
        collectionView.allowsMultipleSelection = false
        withoutActivitiesLabel.text = NSLocalizedString("without_activities_label", comment: "")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if (!_preselectedItems.isEmpty) {
            for preselected in _preselectedItems {
                if let i = items.firstIndex(where: {$0.id == preselected.id}) {
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

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let model = items[indexPath.row]
        
        if let icon = model.icon {
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
                        
                        (cell as! ActivityStripCell).imageView.image = image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
                        cell.tintColor = UIColor.customOrange
                    }
                }
                
                operationQueue.addOperation( downloadOperation )
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = items[indexPath.row]
        delegate?.activityStripViewDelegate(self, didSelectActivity: model)
    }
}
