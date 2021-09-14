//
//  CitiesPresenterImp.swift
//  WeatherMap
//
//  Created by Alexander Airumyan on 11.09.2021.
//

import Foundation

final class CitiesPresenterImp {
    weak var view: CitiesView?
}

// MARK: - CitiesPresenter

extension CitiesPresenterImp: CitiesPresenter {
    func didTriggerViewReadyEvent() {
        let moscow = City()
        moscow.city = "Moscow"
        moscow.temp = "+23"
        
        let krasnodar = City()
        krasnodar.city = "Krasnodar"
        krasnodar.temp = "+30"
        
        let cupertino = City()
        cupertino.city = "Cupertino"
        cupertino.temp = "+50"
        
        let citiesArray = [moscow, krasnodar, cupertino]
        
        view?.updateCities(citiesArray)
    }
}
