//
//  NasaAPI.swift
//  BeautifulSpace
//
//  Created by Михаил Иванов on 24.09.2021.
//

import Foundation

class NasaAPI {
    private let session = URLSession.self
    
    typealias Handler = (Result<[SpaceObject], Error>) -> Void
    
    enum methodURL: String {
        case apod = "https://api.nasa.gov/planetary/apod?api_key=zRvA8ed1SJNn18RXbPMWjdX83eiq18JDsnJbk703&count=5"
    }
    
    private init() {
    }
    
    static let shared = NasaAPI()
    
    func getSpaceObjects(url: methodURL, then handler: @escaping Handler) {
        
        guard let url = URL(string: url.rawValue) else {
            return
        }
        
        session.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "Не известная ошибка")
                return
            }
            do {
                let spases = try JSONDecoder().decode([SpaceObject].self, from: data)
                handler(.success(spases))
            } catch let error{
                handler(.failure(error))
            }
        }.resume()
    }
}

enum Result<Value, Error: Swift.Error> {
    case success(Value)
    case failure(Error)
}
