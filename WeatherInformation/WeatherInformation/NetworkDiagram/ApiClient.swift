//
//  ApiClient.swift
//  WeatherInformation
//
//  Created by Monika Jadhav on 21/05/20.
//  Copyright © 2020 Monika Jadhav. All rights reserved.
//

import Foundation

class ApiClient {
    
    /// "Result" type is used for fecting response success or failure
    func getInitialCitiesTemperatureList(completion: @escaping (Result<InitialTemperature, Error>) -> Void) {
        let urlString = WeatherApi.weatherForSydneyMelbourneAndBrisbane()
        performRequestForGETAPI(requestUrl: URL(string: urlString)!,resultType: InitialTemperature.self) { result in
            switch(result) {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getAllCityDetailWeather(cityId: Int ,completion: @escaping (Result<CityWether, Error>) -> Void) {
        let urlString = WeatherApi.weatherForPerticularCity(id: cityId)
        performRequestForGETAPI(requestUrl: URL(string: urlString)!,resultType: CityWether.self) { result in
            switch(result) {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    //MARK: - Private methods for GET API
    private func performRequestForGETAPI<T: Decodable>(requestUrl: URL, resultType: T.Type , completion: @escaping (Result<T, Error>) -> Void) {
        URLSession.shared.dataTask(with: requestUrl) { (data, response, error) in
            if let err = error {
                completion(.failure(err))
                print(err.localizedDescription)
            } else {
                guard let data = data else { return }
                let jsonString = String(decoding: data, as: UTF8.self)
                do {
                    let results = try JSONDecoder().decode(T.self, from: jsonString.data(using: .utf8)!)
                    completion(.success(results))
                } catch {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
}
