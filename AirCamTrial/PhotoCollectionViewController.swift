//
//  ViewController.swift
//  AirCamTrial
//
//  Created by Adrian Coroian on 6/4/18.
//  Copyright © 2018 Adrian Coroian. All rights reserved.
//

import UIKit

class PhotoCollection: UICollectionViewController {
    let viewModel = PhotoCollectionViewModel()
    var layout: ThreeTabFlowLayout!
    var itemsCount : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        (self.collectionView?.delegate as! CollectionViewDelegate).shouldLoadMore = { index in
            self.viewModel.shouldLoadMore(currentIndex: index)
        }
        
        self.collectionView?.isPagingEnabled = false
        
        viewModel.dataUpdated = {
            DispatchQueue.main.async {
                if(self.itemsCount == self.viewModel.photoUrls.count) { return }
                
                (self.collectionView?.dataSource as! CollectionViewDataSource).data = self.viewModel.photoUrls
                self.itemsCount = self.viewModel.photoUrls.count
                
                if(self.viewModel.photoUrls.count == self.viewModel.moreCells) {
                    self.collectionView?.reloadData()
                } else {
                    
                    var indexPaths : [IndexPath] = []
                    for i in self.viewModel.photoUrls.count-self.viewModel.moreCells...self.viewModel.photoUrls.count-1 {
                        indexPaths.append(IndexPath(row: i, section: 0))
                    }
                    
                    
                    
                    self.collectionView?.performBatchUpdates({
                        self.collectionView?.insertItems(at:indexPaths)
                    }, completion: nil)
                    
                }
            }
        }
        
        layout = ThreeTabFlowLayout()
        collectionView?.collectionViewLayout = layout
        collectionView?.backgroundColor = .black
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

