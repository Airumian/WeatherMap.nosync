//
//  CitiesAssembly.swift
//  WeatherMap
//
//  Created by Alexander Airumyan on 11.09.2021.
//

import Foundation

final class CitiesAssembly {
    static func assembly() -> CitiesViewController {
        let controller = CitiesViewController()
        let presenter = CitiesPresenterImp()
        
        controller.presenter = presenter
        presenter.view = controller
        
        return controller
    }
}
