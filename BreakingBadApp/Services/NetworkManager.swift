//
//  NetworkManager.swift
//  BreakingBadApp
//
//  Created by roman Khilchenko on 21.11.2022.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

enum Link: String {
    case BreakingBadAPI = "https://breakingbadapi.com/api/characters/"
}

final class NetworkManager {
    
    static let share = NetworkManager()
    
    private init () {}
    
    func fetchData(from url: String?, with completion: @escaping([Character]) -> Void ) {
        guard let url = URL(string: url ?? "") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _ , error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let breakingBad = try JSONDecoder().decode([Character].self, from: data)
                DispatchQueue.main.async {
                    completion(breakingBad)
                    print(breakingBad)
                }
                
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func fetchImage(from url: String?, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: url ?? "") else {
            completion(.failure(.invalidURL))
            return
        }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
}




