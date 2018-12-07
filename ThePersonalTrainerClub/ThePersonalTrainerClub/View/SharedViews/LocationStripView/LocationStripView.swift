//
//  LocationStripView.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 18/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import UIKit

protocol LocationStripViewDelegate {
    func onLocationTapped(_ model: LocationModel)
}

class LocationStripView: UIView, NibLoadableView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    private enum Constants {
        static let height: CGFloat = 40
    }

    // MARK: - Overrides
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var delegate: LocationStripViewDelegate?
    
    var allowSelection: Bool = true
    
    // MARK: - Properties
    
    var items: [LocationModel] {
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
    
    private var _items: [LocationModel] = []

    // MARK: - Methods
    
    func invalidateLayout() {
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    func selectFirst() {
        if collectionView.numberOfItems(inSection: 0) == 0 {
            return
        }
        
        collectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: UICollectionView.ScrollPosition.top)
    }
    
    func selectItemAt(_ row: Int) {
        if collectionView.numberOfItems(inSection: 0) == 0 {
            return
        }
        
        collectionView.selectItem(at: IndexPath(row: row, section: 0), animated: false, scrollPosition: UICollectionView.ScrollPosition.top)
    }
    
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
        cell.allowSelection = allowSelection
        
        let model = items[indexPath.row]
        cell.locationLabel.text = "  \( model.description)"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                                 layout collectionViewLayout: UICollectionViewLayout,
                                 sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = 40.0
        // let width = UIScreen.main.bounds.width
        let width = bounds.size.width
        return CGSize(width: width, height: CGFloat( height ))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = items[indexPath.row]
        delegate?.onLocationTapped(model)
    }
}
