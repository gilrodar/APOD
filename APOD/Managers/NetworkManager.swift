//
//  NetworkManager.swift
//  APOD
//
//  Created by Gil Rodarte on 06/11/20.
//

import Alamofire

struct NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func getPhotoInfo(date: String, completion: @escaping (Result<PhotoInfo, AFError>) -> ()) {
        AF.request("https://api.nasa.gov/planetary/apod?api_key=PFDIgD0KfBQoNIuClOrcZuGaFhgUNjXrbNEEFIkx&date=\(date)")
            .validate(statusCode: 200..<300)
            .responseDecodable(of: PhotoInfo.self) { (response) in
                completion(response.result)
            }
    }
    
}
