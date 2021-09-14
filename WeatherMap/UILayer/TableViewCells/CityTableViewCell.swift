//
//  CityTableViewCell.swift
//  WeatherMap
//
//  Created by Alexander Airumyan on 13.09.2021.
//

import UIKit

class CityTableViewCell: UITableViewCell {
    
    // MARK: - Private Properties
    
    private var titleLabel = UILabel()
    private var temperatureLabel = UILabel()
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupConstraints()
        
        backgroundColor = .white
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Internal Methods
    
    func configure(title: String, temperature: String) {
        titleLabel.text = title
        temperatureLabel.text = temperature
    }
}

// MARK: - Private Methods
private extension CityTableViewCell {
    func setupConstraints() {
        [titleLabel,
         temperatureLabel
        ].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor,
                                            constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: temperatureLabel.leadingAnchor,
                                                 constant: -16),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                               constant: -8),
            
            temperatureLabel.topAnchor.constraint(equalTo: contentView.topAnchor,
                                                  constant: 8),
            temperatureLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                       constant: -16),
            temperatureLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                                       constant: -8),
            temperatureLabel.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
}
