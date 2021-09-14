//
//  NetworkService.swift
//  WeatherMap
//
//  Created by Alexander Airumyan on 10.09.2021.
//

import Foundation
import CoreLocation

class NetworkWeatherManager {
    
    func fetchCurrentWeather(latitude: String,
                             longitude: String,
                             completion: @escaping ((Weather) -> Void)) {
        let urlString =
            "http://www.7timer.info/bin/api.pl?lon=\(longitude)&lat=\(latitude)&product=astro&output=json"
        performRequest(withURLString: urlString, completion: completion)
    }
}

private extension NetworkWeatherManager {
    func performRequest(withURLString urlString: String,
                        completion: @escaping ((Weather) -> Void)) {
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let data = data {
                if let currentWeather = self.parseJSON(withData: data) {
                    DispatchQueue.main.async {
                        completion(currentWeather)
                    }
                }
            }
        }
        task.resume()
    }
    
    func parseJSON(withData data: Data) -> Weather? {
        let decoder = JSONDecoder()
        do {
            return try decoder.decode(Weather.self, from: data)
        } catch let error as NSError {
            print(error)
            return nil
        }
    }
}
