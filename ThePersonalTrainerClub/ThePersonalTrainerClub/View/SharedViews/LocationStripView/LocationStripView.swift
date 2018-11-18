//
//  LocationStripView.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 18/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import UIKit

class LocationStripView: UIView, NibLoadableView, UICollectionViewDelegate,  UICollectionViewDataSource {

    private enum Constants {
        static let height: CGFloat = 40
    }

    // MARK: - Overrides
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    
    var items: [LocationModel] {
        get { return _items }
        set {
            _items = newValue
            collectionView.reloadSections(IndexSet(integer: 0))
        }
    }
    
    private var _items: [LocationModel] = []

    // MARK: - Overrides
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Register the cell
        collectionView.register(LocationStripCell.self)
        collectionView.allowsMultipleSelection = false
    }
    
    // MARK: - UICollectionViewDatasource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LocationStripCell", for: indexPath) as! LocationStripCell
        
        let model = items[indexPath.row]
        cell.locationLabel.text = "  \( model.description)"
        
        return cell
    }
}
