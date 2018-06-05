//
//  ImageCell.swift
//  AirCamTrial
//
//  Created by Adrian Coroian on 6/4/18.
//  Copyright © 2018 Adrian Coroian. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class PhotoCell: UICollectionViewCell, Configurable {
    var model: Photo?

    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureWithModel(_ model: Photo) {
        self.model = model
        
        guard let photoString = self.model?.photoString() else { return }
        Alamofire.request(photoString).responseData { response in
            if let imageData = response.result.value {
                let image = UIImage(data: imageData, scale: UIScreen.main.scale)!
                image.af_inflate()
                self.imageView.image = image
            }
        }
    }
}
