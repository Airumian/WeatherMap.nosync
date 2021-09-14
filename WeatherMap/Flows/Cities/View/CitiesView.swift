//
//  CitiesView.swift
//  WeatherMap
//
//  Created by Alexander Airumyan on 11.09.2021.
//

import Foundation

protocol CitiesView: AnyObject {
    func updateCities(_ citiesArray: [City])
}
