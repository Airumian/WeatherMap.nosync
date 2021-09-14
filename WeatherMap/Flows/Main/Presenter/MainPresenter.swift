//
//  MainPresenter.swift
//  WeatherMap
//
//  Created by Alexander Airumyan on 10.09.2021.
//

import Foundation

protocol MainPresenter {
    func fetchCurrentWeather(latitude: Double, longitude: Double)
    func saveCity(city: String)
}
