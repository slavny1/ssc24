//
//  File.swift
//  
//
//  Created by Вячеслав Горев on 20/1/2024.
//

import Foundation
import Combine

class DataService {
    func fetchCityData() -> AnyPublisher<City, Error> {

        guard let jsonURL = Bundle.main.url(forResource: "world_cities", withExtension: "json") else {
            return Fail(error: URLError(.fileDoesNotExist))
                .eraseToAnyPublisher()
        }

        return Just(jsonURL)
            .tryMap { url in
                let data = try Data(contentsOf: url)
                return data
            }
            .decode(type: City.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
