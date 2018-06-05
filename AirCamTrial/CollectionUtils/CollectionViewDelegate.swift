//
//  CollectionViewDelegate.swift
//  AirCamTrial
//
//  Created by Adrian Coroian on 6/5/18.
//  Copyright © 2018 Adrian Coroian. All rights reserved.
//

import UIKit

class CollectionViewDelegate: NSObject, UICollectionViewDelegate {
    var shouldLoadMore : ((_ index : Int) -> Void)?
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.shouldLoadMore?(indexPath.row)
    }
}
