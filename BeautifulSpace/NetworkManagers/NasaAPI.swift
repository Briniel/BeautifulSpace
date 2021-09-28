//
//  NasaAPI.swift
//  BeautifulSpace
//
//  Created by Михаил Иванов on 24.09.2021.
//

import Foundation
import Alamofire

class NasaAPI {
    typealias Handler = (Result<Any, NetworkError>) -> Void
    
    enum methodURL: String {
        case apod = "https://api.nasa.gov/planetary/apod?api_key=zRvA8ed1SJNn18RXbPMWjdX83eiq18JDsnJbk703&count=5"
    }
    
    private init() {
    }
    
    static let shared = NasaAPI()
    
    func getSpaceObjects(url: methodURL, then handler: @escaping Handler) {
        AF.request(url.rawValue)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                    case .success(let value):
                        let spaceObjects = SpaceObject.getSpaceObjects(from: value)
                        DispatchQueue.main.async {
                            handler(.success(spaceObjects))
                        }
                    case .failure:
                        handler(.failure(.errorForDecode))
                }
            }
    }
    
    func getSpaceImage(url: String, then handler: @escaping Handler) {
        DispatchQueue.global().async {
        guard let url = URL(string: url) else {
            handler(.failure(.badURL))
            return
        }
        guard let imageData = try? Data(contentsOf: url) else {
            handler(.failure(.errorConnect))
            return
        }
            DispatchQueue.main.async {
        handler(.success(imageData))
            }
            
        }
        
    }
}


enum NetworkError: Error {
    case badURL
    case errorForDecode
    case errorConnect
    
}
