//
//  WeatherView.swift
//  WeatherMap
//
//  Created by Alexander Airumyan on 08.09.2021.
//

import UIKit

class WeatherView: UIView {
    
    // MARK: - Private Properties
    
    private let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
    
    private let loadingActivityIndicatorView = UIActivityIndicatorView()
    private let latitudeLabel = UILabel()
    private let longtitudeLabel = UILabel()
    private let temperatureLabel = UILabel()
    
    // MARK: - Initialization
    
    init() {
        super.init(frame: .zero)
        addBlurEffect()
        setupConstraints()
        setupLabels()
        loadingActivityIndicatorView.startAnimating()
        loadingActivityIndicatorView.color = .systemBlue
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Intetnal Methods
    
    func configure(latitude: Double,
                   longitude: Double) {
        latitudeLabel.text = getFormatedLatitude(latitude)
        longtitudeLabel.text = getFormatedLongtitude(longitude)
    }
    
    func updateTemperature(_ temperature: String) {
        temperatureLabel.text = temperature
        loadingActivityIndicatorView.stopAnimating()
    }
}


// MARK: - Private Methods
private extension WeatherView {
    func setupConstraints() {
        [latitudeLabel,
         longtitudeLabel,
         temperatureLabel,
         loadingActivityIndicatorView
        ].forEach { customView in
            addSubview(customView)
            customView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            latitudeLabel.topAnchor.constraint(equalTo: topAnchor,
                                               constant: 16),
            latitudeLabel.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                   constant: 16),
            latitudeLabel.trailingAnchor.constraint(equalTo: temperatureLabel.trailingAnchor,
                                               constant: -16),
            
            longtitudeLabel.topAnchor.constraint(equalTo: latitudeLabel.bottomAnchor,
                                                 constant: 16),
            longtitudeLabel.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                      constant: 16),
            longtitudeLabel.trailingAnchor.constraint(equalTo: temperatureLabel.trailingAnchor,
                                               constant: -16),
            longtitudeLabel.bottomAnchor.constraint(equalTo: bottomAnchor,
                                                    constant: -16),
            
            temperatureLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            temperatureLabel.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                       constant: -16),
            temperatureLabel.widthAnchor.constraint(equalToConstant: 70),
            
            loadingActivityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor),
            loadingActivityIndicatorView.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                       constant: -16),
            loadingActivityIndicatorView.widthAnchor.constraint(equalToConstant: 70),
           
        ])
    }
    
    func addBlurEffect() {
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(blurEffectView)
    }
    
    func getFormatedLatitude(_ latitude: Double) -> String {
        let formatedDoubleLatitude = String(format: "%.4f", latitude)
        return "Широта: " + formatedDoubleLatitude
    }
    
    func getFormatedLongtitude(_ longtitude: Double) -> String {
        let formatedDoubleLongtitude = String(format: "%.4f", longtitude)
        return "Долгота: " + formatedDoubleLongtitude
    }
    
    func setupLabels() {
        latitudeLabel.textColor = .systemBlue
        longtitudeLabel.textColor = .systemBlue
        temperatureLabel.textColor = .systemBlue
    }
}
