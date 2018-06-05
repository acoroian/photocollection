//
//  PhotoCollectionViewModel.swift
//  AirCamTrial
//
//  Created by Adrian Coroian on 6/4/18.
//  Copyright © 2018 Adrian Coroian. All rights reserved.
//

import UIKit
import Alamofire

let baseUrl = "https://s3-us-west-2.amazonaws.com/aircam-test/scroll-test/"

class PhotoCollectionViewModel {
    
    var photoUrls : [Photo] = []
    var currentPhoto : Photo = Photo(imageNumber: 0, day: 1, cameraType: .sony)
    
    var dataUpdated : (() -> Void)?
    
    init() {
        self.refreshData()
    }
    
    func refreshData() {
        self.photoUrls = []
        self.currentPhoto = Photo(imageNumber: 0, day: 1, cameraType: .sony)
        getNextPhotos(photo: currentPhoto)
    }
    
    func shouldLoadMore(currentIndex: Int) {
        if photoUrls.count - 15 == currentIndex {
            getNextPhotos(photo: self.currentPhoto)
        }
    }
    
    // Shouldn't need to touch anything above here

    
    // Given that we're on one photo, get the next 5 photos, using photoExists to check if the photo is valid
    func getNextPhotos(photo: Photo) {
        DispatchQueue.global(qos: .background).async {
            self.currentPhoto = photo
            
            var types : [CameraType] = [.sony, .canon, .nikon]
            var typeIndex = types.index(of: self.currentPhoto.cameraType)!
            
            self.currentPhoto.exists { (exists) in
                if(exists) {
                    self.photoUrls.append(self.currentPhoto)
                    self.currentPhoto.imageNumber += 1
                    if(self.photoUrls.count % 30 > 0)  {
                        self.getNextPhotos(photo: self.currentPhoto)
                    } else {
                        self.dataUpdated?()
                    }
                } else {
                    self.currentPhoto.imageNumber  = 0
                    
                    if typeIndex < types.count-1 {
                        typeIndex += 1
                        self.currentPhoto.cameraType = types[typeIndex]
                        if(self.photoUrls.count % 30 > 0)  {
                            self.getNextPhotos(photo: self.currentPhoto)
                        } else {
                            self.dataUpdated?()
                        }
                    } else {
                        typeIndex = 0
                        self.currentPhoto.day += 1
                        self.currentPhoto.cameraType = types[0]
                        if(self.currentPhoto.day <= 31 && self.photoUrls.count % 24 > 0) {
                            self.getNextPhotos(photo: self.currentPhoto)
                        } else {
                            self.dataUpdated?()
                        }
                    }
                }
            }
        }
    }
}