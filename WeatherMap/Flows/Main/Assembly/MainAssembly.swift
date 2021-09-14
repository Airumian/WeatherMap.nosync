//
//  MainAssembly.swift
//  WeatherMap
//
//  Created by Alexander Airumyan on 10.09.2021.
//

import Foundation

final class MainAssembly {
    static func assembly() -> MainViewController {
        let controller = MainViewController()
        let presenter = MainPresenterImp()
        
        controller.presenter = presenter
        presenter.view = controller
        
        return controller
    }
}
