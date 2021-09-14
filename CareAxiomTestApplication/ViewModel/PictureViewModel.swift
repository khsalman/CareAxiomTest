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
    
    // MARK: - Variables & Constants
    private var apiService : APIService!
    private var picDataArr : [PictureData]?
    private(set) var picDataDic : PicDataDic?
    var picDicAllKeys : [String]? = nil
    var bindPictureViewModelToCAImagesViewController : (() -> ()) = {}
    
    // MARK: - Initialiser
    override init() {
        super.init()
        self.apiService = APIService()
        self.getPicturesData()
    }
    
    // MARK: - Get Data From API Service
    func getPicturesData() {
        if(InternetConnection.sharedInstance.isInternetConnected == true){
            self.apiService.apiToGetPictureData { [self] (picturesData) in
                if picturesData != nil {
                    self.picDicAllKeys?.removeAll()
                    self.picDataArr = picturesData
                    // Sort the self.picData and store into picData
                    self.picDataDic = self.sortArrAsPerAlbumId(picArr: &picDataArr!)
                    // Also save the data as well.
                    self.savePictureData(picturesData: self.picDataDic!)
                    self.bindPictureViewModelToCAImagesViewController()
                }else {
                    print("Get nil against Pic Data")
                }
            }
        }else {
            print("Internet not available")
            if let data = self.fetchPreSavedData(key: Constants.picDataKey) {
                self.picDataDic = data
            }
        }
    }
    
    // MARK: - Sort Array & Manage Data Structure
    func sortArrAsPerAlbumId(picArr :inout [PictureData]) -> PicDataDic {
        var dict = PicDataDic(dic: [:])
        if picArr.count > 0 {
            // We have a sorted array here
            picArr = picArr.sorted(by : {$0.albumId < $1.albumId})
            
            var tempValue = picArr[0].albumId
            var pic = [PictureData]()
            pic.append(picArr[0])
            dict.dic["\(tempValue)"] = pic
            
            for i in 1..<picArr.count {
                if picArr[i].albumId == tempValue {
                }else {
                    tempValue = picArr[i].albumId
                    pic.removeAll()
                }
                pic.append(picArr[i])
                dict.dic["\(tempValue)"] = pic
            }
        }
        
        return dict
    }
    
    // MARK: - Data Persistence Methods
    func savePictureData(picturesData : PicDataDic) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(picturesData) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: Constants.picDataKey)
        }
    }
    
    func fetchPreSavedData(key : String) -> PicDataDic? {
        let defaults = UserDefaults.standard
        if let savedItem = defaults.object(forKey: Constants.picDataKey) as? Data {
            let decoder = JSONDecoder()
            if let loadedDic = try? decoder.decode(PicDataDic.self, from: savedItem) {
                return loadedDic
            }
        }
        return nil
    }
    
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    
    // MARK: - Helper Methods for Data Accession
    func getAllKeysCount(picDict : PicDataDic?) -> Int {
        guard picDict != nil else {return 0}
        return picDict!.dic.keys.count
    }
    
     func getAllKeys() -> [String]{
        guard let dict  = self.picDataDic else {return []}
        let keys = dict.dic.keys.sorted(by: <)
        return keys
    }
    
    func getParticularKey(index : Int) -> String {
        if self.picDicAllKeys == nil {
            self.picDicAllKeys = self.getAllKeys()
        }
        
        if self.picDicAllKeys?.count == 0 {
            self.picDicAllKeys = self.getAllKeys()
        }
        
        if self.picDicAllKeys != nil {
            if self.picDicAllKeys!.count > index {
                return self.picDicAllKeys![index]
            }
        }
        return "NIL"
    }
    
}
