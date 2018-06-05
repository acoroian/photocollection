//
//  ReditModel.swift
//  Reddit-Ring
//
//  Created by Adrian Coroian on 5/1/18.
//  Copyright © 2018 Adrian Coroian. All rights reserved.
//

import UIKit

protocol CollectionViewCompatible {
    var reuseIdentifier: String { get }
    func cellForCollectionView(collectionView: UICollectionView, atIndexPath indexPath: IndexPath) -> UICollectionViewCell
    
}
