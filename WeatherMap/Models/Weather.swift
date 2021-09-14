//
//  Weather.swift
//  WeatherMap
//
//  Created by Alexander Airumyan on 10.09.2021.
//

import Foundation

// MARK: - Weather
struct Weather: Codable {
    let product, weatherInit: String
    let dataseries: [Datasery]

    enum CodingKeys: String, CodingKey {
        case product
        case weatherInit = "init"
        case dataseries
    }
}

// MARK: - Datasery
struct Datasery: Codable {
    let timepoint, cloudcover, seeing, transparency: Int
    let liftedIndex, rh2M: Int
    let wind10M: Wind10M
    let temp2M: Int
    let precType: PrecType

    enum CodingKeys: String, CodingKey {
        case timepoint, cloudcover, seeing, transparency
        case liftedIndex = "lifted_index"
        case rh2M = "rh2m"
        case wind10M = "wind10m"
        case temp2M = "temp2m"
        case precType = "prec_type"
    }
}

enum PrecType: String, Codable {
    case none = "none"
    case rain = "rain"
}

// MARK: - Wind10M
struct Wind10M: Codable {
    let direction: String
    let speed: Int
}
