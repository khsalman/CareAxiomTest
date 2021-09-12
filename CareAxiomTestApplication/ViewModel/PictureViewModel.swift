//
//  PictureViewModel.swift
//  CareAxiomTestApplication
//
//  Created by Khawaja Salman Nadeem on 11/09/2021.
//

import Foundation
import CoreData
import UIKit

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
        if(InternetConnection.sharedInstance.isInternetConnected == true){
            self.apiService.apiToGetPictureData { (picturesData) in
                if picturesData != nil {
                    print(picturesData as Any)
                    self.picData = picturesData
                    // Also save the data as well.
                    self.savePictureData(picturesData: self.picData!)
                }else {
                    print("Get nil against Pic Data")
                }
            }
        }else {
            print("Internet not available")
            self.picData = self.fetchPreSavedData(key: Constants.picDataKey)
            print(picData as Any)
        }
    }
    
    func savePictureData(picturesData : [PictureData]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(picturesData) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: Constants.picDataKey)
        }
    }
    
    func fetchPreSavedData(key : String) -> [PictureData] {
        let defaults = UserDefaults.standard
        if let savedItem = defaults.object(forKey: Constants.picDataKey) as? Data {
            let decoder = JSONDecoder()
            if let loadedArr = try? decoder.decode([PictureData].self, from: savedItem) {
                print(loadedArr)
                return loadedArr
            }
        }
        return []
    }
    
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    
}
