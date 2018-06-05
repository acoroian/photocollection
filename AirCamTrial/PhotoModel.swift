//
//  PhotoModel.swift
//  AirCamTrial
//
//  Created by Adrian Coroian on 6/4/18.
//  Copyright © 2018 Adrian Coroian. All rights reserved.
//

import UIKit
import Alamofire

enum CameraType: String {
    case sony, nikon, canon
}

extension Int {
    func paddedString() -> String {
        return self < 10 ? "0\(self)" : "\(self)"
    }
}

struct Photo {
    var imageNumber: Int
    var day: Int
    var cameraType: CameraType
    
    func photoString() -> String {
        let numberPhoto = self.imageNumber.paddedString()
        let numberDate = "201801\(self.day.paddedString())"
        
        let photoString = "\(baseUrl)\(self.cameraType)/\(numberDate)/\(numberPhoto).jpg"
        
        return photoString
    }

    func exists(completion: @escaping (_ exists: Bool) -> Void) {
        Alamofire.request(self.photoString(), method: .head, parameters: nil, encoding: JSONEncoding.default, headers:nil).response { response in
            DispatchQueue.global(qos: .background).async {
                completion(response.response?.statusCode == 200)
            }
        }
    }
}

extension Photo : CollectionViewCompatible {
    var reuseIdentifier: String {
        return "PhotoCellIdentifier"
    }
    
    func cellForCollectionView(collectionView: UICollectionView, atIndexPath indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.reuseIdentifier, for: indexPath) as! PhotoCell
        cell.configureWithModel(self)
        return cell
    }
    

}


