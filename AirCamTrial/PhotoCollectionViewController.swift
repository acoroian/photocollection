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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        (self.collectionView?.delegate as! CollectionViewDelegate).shouldLoadMore = { index in
            self.viewModel.shouldLoadMore(currentIndex: index)
        }
        
        viewModel.dataUpdated = {
            DispatchQueue.main.async {
                (self.collectionView?.dataSource as! CollectionViewDataSource).data = []
                (self.collectionView?.dataSource as! CollectionViewDataSource).data.append(contentsOf: self.viewModel.photoUrls)
                self.collectionView?.reloadData()
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

