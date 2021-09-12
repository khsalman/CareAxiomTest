//
//  ApiService.swift
//  CareAxiomTestApplication
//
//  Created by Khawaja Salman Nadeem on 11/09/2021.
//

import Foundation

class APIService :  NSObject {
    private let sourcesURL = URL(string: Constants.picDataUrl)!
    func apiToGetPictureData(completion : @escaping ([PictureData]?) -> ()){
        URLSession.shared.dataTask(with: sourcesURL) { (data, urlResponse, error) in
            if let data = data {
                if error == nil {
                    let jsonDecoder = JSONDecoder()
                    let picData = try! jsonDecoder.decode([PictureData].self, from: data)
                    completion(picData)
                }else {
                    print("Error = \(String(describing: error?.localizedDescription))")
                    completion(nil)
                }
            }
        }.resume()
    }
}
