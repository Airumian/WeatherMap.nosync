//
//  MainPresenterImp.swift
//  WeatherMap
//
//  Created by Alexander Airumyan on 10.09.2021.
//

import RealmSwift
import Foundation

final class MainPresenterImp {
    weak var view: MainView?
    
    private let networkWeatherService = NetworkWeatherManager()
    
    private var currentLatitude: Double?
    private var currentLongitude: Double?
}

extension MainPresenterImp: MainPresenter {
    func fetchCurrentWeather(latitude: Double, longitude: Double) {
        let latitudeString = latitude.description
        let longitudeString = longitude.description
        let hour = Calendar.current.component(.hour, from: Date())
        
        guard currentLatitude != latitude && currentLongitude != longitude else { return }
        currentLongitude = longitude
        currentLatitude = latitude
        
        networkWeatherService.fetchCurrentWeather(latitude: latitudeString, longitude: longitudeString) { [weak self] weather in
            guard let temperature = weather.dataseries[safeIndex: hour-1]?.temp2M else { return }
            let formatedTemperature = temperature.description + " °C"
            self?.view?.updateTemperature(formatedTemperature)
        }
    }
    
    func saveCity(city: String) {
        
    }
}

extension Array {
    public subscript(safeIndex index: Int) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }

        return self[index]
    }
}
