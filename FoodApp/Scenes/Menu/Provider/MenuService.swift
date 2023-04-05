//
//  MenuService.swift
//  FoodApp
//
//  Created by G on 03.04.2023.
//

import Foundation

protocol NetworkServicing: AnyObject {
    func fetchMenu(completion: @escaping (Result<[FoodModel], Error>) -> Void)
}

final class MenuService: NetworkServicing {
    private let jsonDecoder: JSONDecoder
    private let uri: String
    
    init(decoder: JSONDecoder = JSONDecoder(), uri: String) {
        self.jsonDecoder = decoder
        self.uri = uri
    }
    
    func fetchMenu(completion: @escaping (Result<[FoodModel], Error>) -> Void) {
        guard let url = URL(string: uri) else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            DispatchQueue.main.async {
                if let error {
                    completion(.failure(error))
                    return
                }
                guard
                    let data = data,
                    let decodedData = try? self?.jsonDecoder.decode([FoodModel].self, from: data)
                else {
                    completion(.failure(URLError(.badServerResponse)))
                    return
                }
                completion(.success(decodedData))
            }
        }
        dataTask.resume()
    }
}
