//
//  NetworkManager.swift
//  PizzaApp
//
//  Created by Jozef Gmuca on 09/06/2023.
//

import Foundation

struct ServerAPI {
    enum Environment: String {
        case testEnvironment = "https://doclerlabs.github.io/mobile-native-challenge/"
    }
    private static let basePath: String = ServerAPI.Environment.testEnvironment.rawValue
    enum Api: String {

        case ingredients = "ingredients.json"
        case drinks = "drinks.json"
        case pizzas =  "pizzas.json"
    }
    func loadData<T: Decodable>(urlString: ServerAPI.Api, completion: @escaping (T) -> Void ) {
        let url = URL(string: urlString.string())
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: url!) { (data, _, error) in
            if let error = error {
                print("Failed to fetch data:", error)
                return
            }

            guard let data = data else { return }

            do {
                let obj = try JSONDecoder().decode(T.self, from: data)
                completion(obj)
            } catch let jsonErr {
                print("Failed to decode json:", jsonErr)
            }
        }
        dataTask.resume()
    }
}

extension ServerAPI.Api {
    func url() -> URL? {
        return (URL(string: ServerAPI.basePath + self.rawValue))
    }
    func string() -> String {
        return ServerAPI.basePath + self.rawValue
    }

}
