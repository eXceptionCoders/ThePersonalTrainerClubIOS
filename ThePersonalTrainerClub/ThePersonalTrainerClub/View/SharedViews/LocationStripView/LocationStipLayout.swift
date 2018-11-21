//
//  LocationStipLayout.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 18/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import UIKit

final class LocationStripLayout: UICollectionViewFlowLayout {
    private enum Constants {
        static let minimumLineSpacing: CGFloat = 1
        static let sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    override func prepare() {
        guard let collectionView = collectionView else {
            return
        }
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.scrollsToTop = false
        
        scrollDirection = .vertical
        minimumInteritemSpacing = 0
        minimumLineSpacing = Constants.minimumLineSpacing
        // sectionInset = Constants.sectionInset
    }
    /*
    func itemWidth() -> CGFloat {
        return collectionView!.bounds.size.width - 40
    }
    
    func itemHeight() -> CGFloat {
        return 40.0
    }
    
    override var itemSize: CGSize {
        get {
            return CGSize(width: itemWidth(), height: itemHeight())
        }
        set {
            super.itemSize = CGSize(width: itemWidth(), height: itemHeight())
        }
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        return collectionView!.contentOffset
    }
    */

}
