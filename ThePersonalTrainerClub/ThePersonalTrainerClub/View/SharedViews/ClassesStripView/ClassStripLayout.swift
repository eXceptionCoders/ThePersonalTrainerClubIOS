//
//  ClassStripLayout.swift
//  ThePersonalTrainerClub
//
//  Created by VINACHES LOPEZ JORGE on 30/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import UIKit

final class ClassStripLayout: UICollectionViewFlowLayout {
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
    }
}
