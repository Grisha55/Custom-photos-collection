//
//  NetworkService.swift
//  Custom photos collection
//
//  Created by Григорий Виняр on 16/06/2022.
//

import UIKit

class NetworkService {
    
    func getDataFromService(completion: @escaping ([Albums]) -> Void) {
        
        // https://jsonplaceholder.typicode.com/photos
        
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "jsonplaceholder.typicode.com"
        urlComponents.path = "/photos"
        
        guard let url = urlComponents.url else { return }
        
        session.dataTask(with: url) { data, response, error in
            guard error == nil, let data = data else { return }
            
            do {
                let albums = try JSONDecoder().decode([Albums].self, from: data)
                completion(albums)
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
        
    }
    
}
