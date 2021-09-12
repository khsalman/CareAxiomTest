//
//  PictureViewModel.swift
//  CareAxiomTestApplication
//
//  Created by Khawaja Salman Nadeem on 11/09/2021.
//

import Foundation

class PictureViewModel : NSObject {
    
    private var apiService : APIService!
    
    private(set) var picData : [PictureData]? {
            didSet {
                self.bindPictureViewModelToCAImagesViewController()
            }
        }
        
    var bindPictureViewModelToCAImagesViewController : (() -> ()) = {}
    
    override init() {
        super.init()
        self.apiService = APIService()
        self.getPicturesData()
    }
    
    func getPicturesData() {
        self.apiService.apiToGetPictureData { (picturesData) in
            if picturesData != nil {
                print(picturesData as Any)
                self.picData = picturesData
            }else {
                print("Get Nil against Pic Data")
            }
        }
    }
    
    func savePictureData() {
        
    }
    
    
}
