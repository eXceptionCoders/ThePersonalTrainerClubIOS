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
        static let height: CGFloat = 240
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    
    var items: [ActivityModel] {
        get { return _items }
        set {
            _items = newValue
            collectionView.reloadSections(IndexSet(integer: 0))
        }
    }
    
    private var _items: [ActivityModel] = []

    // MARK: - Overrides
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Register the cell
        collectionView.register(ActivityCell.self)
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: Constants.height)
    }
    
    // MARK: - UICollectionViewDatasource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "activityCell", for: indexPath) as! ActivityCell
        
        let model = items[indexPath.row]
        cell.titleLabel.text = model.name
        
        let url = URL(string: model.thumbnail)
        
        if let url = url {
            let data = try? Data(contentsOf: url)
            
            if let imageData = data {
                cell.imageView.image = UIImage(data: imageData)
            }
        }

        return cell
    }
}
