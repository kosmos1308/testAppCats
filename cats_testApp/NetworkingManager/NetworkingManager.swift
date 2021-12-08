//
//  NetworkingManager.swift
//  cats_testApp
//
//  Created by pavel on 6.12.21.
//

import Foundation

final class NetworkingManager {
    static let shared = NetworkingManager()
    var urlString = "https://api.thecatapi.com/v1/breeds?limit=\(10)"
    var countCats: Int = 10
    private init() {}
    
    func fetchData(completion: @escaping (_ cats: [Cat]) -> Void) {
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                print(error?.localizedDescription ?? "No description")
                return
            }
            
            do {
                let cats = try JSONDecoder().decode([Cat].self, from: data)
                DispatchQueue.main.async {
                    completion(cats)
                }
                
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
