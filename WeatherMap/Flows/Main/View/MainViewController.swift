//
//  MainViewController.swift
//  WeatherMap
//
//  Created by Alexander Airumyan on 08.09.2021.
//

import UIKit
import MapKit

class MainViewController: UIViewController {
    
    // MARK: - Internal Properties
    
    var presenter: MainPresenter?
    
    // MARK: - Private Properties
    
    private let locationButton = UIButton()
    private let weatherView = WeatherView()
    
    private let mapView = MKMapView()
    private let locationManager = CLLocationManager()
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        title = "Карта"
        
        setupConstraints()
        setupMapView()
        setupNavigationButtons()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupLocationButton()
        setupWeatherView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        refreshLocation()
    }
}

// MARK: - MainViewController

private extension MainViewController {
    func setupConstraints() {
        [mapView,
         locationButton,
         weatherView
        ].forEach { customView in
            view.addSubview(customView)
            customView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            locationButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                                   constant: -50),
            locationButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                                     constant: -30),
            locationButton.widthAnchor.constraint(equalToConstant: 40),
            locationButton.heightAnchor.constraint(equalToConstant: 40),
            
            weatherView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                             constant: 30),
            weatherView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                                 constant: 30),
            weatherView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                                  constant: -30)
        ])
    }
    
    func setupNavigationButtons() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search,
                                                           target: self,
                                                           action: #selector(showCities))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(addCity))
    }
    
    @objc func showCities() {
        let citiesVC = CitiesAssembly.assembly()
        navigationController?.pushViewController(citiesVC, animated: true)
    }
    
    @objc func addCity() {
        let alertController = UIAlertController(title: "Введите город", message: nil, preferredStyle: .alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Москва"
        }
        
        let saveAction = UIAlertAction(title: "Сохранить", style: .default, handler: { alert -> Void in
            if let textField = alertController.textFields?[0] {
                if textField.text!.count > 0 {
                    self.presenter?.saveCity(city: textField.text ?? "")
                }
            }
        })
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: {
                                            (action : UIAlertAction!) -> Void in })
        
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        
        alertController.preferredAction = saveAction
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func setupMapView() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        
        let scale = MKScaleView(mapView: mapView)
        scale.scaleVisibility = .visible
        view.addSubview(scale)
        mapView.showsScale = true
        mapView.showsUserLocation = true
        
    }
    
    func setupWeatherView() {
        weatherView.layer.cornerRadius = 16
        weatherView.layer.masksToBounds = true
    }
    
    func setupLocationButton() {
        let buttonImage = UIImage(named: "myLocation")
        locationButton.setImage(buttonImage, for: .normal)
        locationButton.addTarget(self, action: #selector(refreshLocation), for: .touchUpInside)
    }
    
    @objc
    func refreshLocation() {
        mapView.setUserTrackingMode(.follow, animated: true)
    }
}

// MARK: - MainView

extension MainViewController: MainView {
    func updateTemperature(_ currentTemperature: String) {
        weatherView.updateTemperature(currentTemperature)
    }
}

// MARK: - CLLocationManagerDelegate

extension MainViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        mapView.showsUserLocation = true
        guard let latitude = manager.location?.coordinate.latitude,
              let longitude = manager.location?.coordinate.longitude
        else { return }
        
        presenter?.fetchCurrentWeather(latitude: latitude, longitude: longitude)
        weatherView.configure(latitude: latitude,
                              longitude: longitude)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        let title = "Ошибка"
        let message = "Не удалось определить Ваше текущее местоположение"
        let errorButtonTitle = "Ok"
        let errorAlert = UIAlertController(title: title,
                                           message: message,
                                           preferredStyle: .alert)
        let errorButton = UIAlertAction(title: errorButtonTitle, style: .default)
        
        errorAlert.addAction(errorButton)
        present(errorAlert, animated: true)
        
    }
}
