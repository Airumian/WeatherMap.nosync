//
//  MainView.swift
//  WeatherMap
//
//  Created by Alexander Airumyan on 10.09.2021.
//

import Foundation

protocol MainView: AnyObject {
    func updateTemperature(_ currentTemperature: String)
}
