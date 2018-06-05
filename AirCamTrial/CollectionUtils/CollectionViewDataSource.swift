//
//  ReditModel.swift
//  Reddit-Ring
//
//  Created by Adrian Coroian on 5/1/18.
//  Copyright © 2018 Adrian Coroian. All rights reserved.
//

import UIKit

class CollectionViewDataSource: NSObject, UICollectionViewDataSource {

    var data = [CollectionViewCompatible]()
    var configure : ((_ cell: UICollectionViewCell, _ index: IndexPath) -> Void)?

    private func numberOfSectionsInCollectionView(collectionView: UICollectionView!) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = data[indexPath.row]
        let cell = model.cellForCollectionView(collectionView: collectionView, atIndexPath: indexPath)
        return cell
    }
}

//extension CollectionViewDataSource : UIDataSourceModelAssociation {
//    func modelIdentifierForElement(at idx: IndexPath, in view: UIView) -> String? {
//        return self.data[idx.section][idx.row].uniqueIdentifier
//    }
//    
//    func indexPathForElement(withModelIdentifier identifier: String, in view: UIView) -> IndexPath? {
//        for section in data {
//            for (index, item) in section.enumerated() {
//                if item.uniqueIdentifier == identifier {
//                    return IndexPath(row: index, section: 0)
//                }
//            }
//        }
//        
//        return IndexPath(row: 0, section: 0)
//    }
//}
