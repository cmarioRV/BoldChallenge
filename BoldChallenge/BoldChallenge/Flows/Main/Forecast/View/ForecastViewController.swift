//
//  ForecastViewController.swift
//  BoldChallenge
//
//  Created by Mario Rúa on 24/02/23.
//

import Foundation
import UIKit
import Domain

class ForecastViewController: UIViewController {
    var viewModel: ForecastViewModelType!
    public var query: String = ""
    
    let scrollView: UIScrollView = {
       let _scrollView = UIScrollView()
        return _scrollView
    }()
    
    let containerView: UIView = {
       let _view = UIView()
        return _view
    }()
    
    let locationLabel: UILabel = {
       let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.font = .systemFont(ofSize: 20, weight: .bold)
        lbl.textColor = .black
        return lbl
    }()
    
    let countryLabel: UILabel = {
       let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.font = .systemFont(ofSize: 15, weight: .regular)
        lbl.textColor = .black
        return lbl
    }()
    
    let stateContainerView: UIView = {
        let _view = UIView()
        return _view
    }()
    
    let temperatureLabel: UILabel = {
       let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.textAlignment = .right
        lbl.font = .systemFont(ofSize: 30, weight: .bold)
        lbl.textColor = .black
        return lbl
    }()
    
    let stateIconImageView: UIImageView = {
       let icon = UIImageView()
        icon.contentMode = .scaleAspectFit
        return icon
    }()
    
    let stateLabel: UILabel = {
       let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.textAlignment = .left
        lbl.font = .systemFont(ofSize: 12, weight: .medium)
        lbl.textColor = .black
        return lbl
    }()
    
    let forecastContainerView = ForecastStateView()
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureContents()
        bindViewModel()
        viewModel.inputs.getForecast(location: query)
    }
    
    fileprivate func configureContents() {
        view.addSubview(scrollView)
        
        let guides = view.safeAreaLayoutGuide
        
        scrollView.addSubview(containerView)
        containerView.addSubview(locationLabel)
        containerView.addSubview(countryLabel)
        containerView.addSubview(stateContainerView)
        stateContainerView.addSubview(temperatureLabel)
        stateContainerView.addSubview(stateIconImageView)
        containerView.addSubview(stateLabel)
        containerView.addSubview(forecastContainerView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        countryLabel.translatesAutoresizingMaskIntoConstraints = false
        stateContainerView.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        stateIconImageView.translatesAutoresizingMaskIntoConstraints = false
        stateLabel.translatesAutoresizingMaskIntoConstraints = false
        forecastContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: guides.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: guides.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: guides.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: guides.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.widthAnchor.constraint(equalTo: guides.widthAnchor)
        ])
        
        containerView.heightAnchor.constraint(equalTo: guides.heightAnchor).priority = .defaultLow
        
        NSLayoutConstraint.activate([
            locationLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 30),
            locationLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            locationLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            countryLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 15),
            countryLabel.leadingAnchor.constraint(equalTo: locationLabel.leadingAnchor),
            countryLabel.trailingAnchor.constraint(equalTo: locationLabel.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            stateContainerView.leadingAnchor.constraint(greaterThanOrEqualTo: containerView.leadingAnchor, constant: 20),
            stateContainerView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            stateContainerView.topAnchor.constraint(equalTo: countryLabel.bottomAnchor, constant: 25)
        ])
        
        NSLayoutConstraint.activate([
            temperatureLabel.leadingAnchor.constraint(equalTo: stateContainerView.leadingAnchor),
            temperatureLabel.topAnchor.constraint(equalTo: stateContainerView.topAnchor),
            temperatureLabel.bottomAnchor.constraint(equalTo: stateContainerView.bottomAnchor),
            temperatureLabel.trailingAnchor.constraint(equalTo: stateIconImageView.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            stateIconImageView.topAnchor.constraint(equalTo: stateContainerView.topAnchor),
            stateIconImageView.bottomAnchor.constraint(equalTo: stateContainerView.bottomAnchor),
            stateIconImageView.trailingAnchor.constraint(equalTo: stateContainerView.trailingAnchor),
            stateIconImageView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.2),
            stateIconImageView.heightAnchor.constraint(equalTo: stateIconImageView.heightAnchor, multiplier: 1)
        ])
        
        NSLayoutConstraint.activate([
            stateLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            stateLabel.topAnchor.constraint(equalTo: stateContainerView.bottomAnchor, constant: 20),
            stateLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            forecastContainerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            forecastContainerView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            forecastContainerView.topAnchor.constraint(equalTo: stateLabel.bottomAnchor, constant: 20),
            forecastContainerView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        
        temperatureLabel.setContentHuggingPriority(.required, for: .horizontal)
    }
    
    private func updateViewWith(forecast: Forecast) {
        locationLabel.text = forecast.locationName
        countryLabel.text = forecast.country
        forecastContainerView.configure(with: .init(forecasts: forecast.days))
        if let temperature = forecast.current.temperature {
            temperatureLabel.text = "\(temperature)ºC"
        }
        else {
            temperatureLabel.text = "--"
        }
        
        if let iconUrlString = forecast.current.stateIcon,
           let iconUrl = URL(string: iconUrlString) {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: iconUrl)
                DispatchQueue.main.async {
                    guard let data = data else { return }
                    self.stateIconImageView.image = UIImage(data: data)
                }
            }
        }
        
    }
    
    private func bindViewModel() {
        viewModel.outputs.forecast.bind { [weak self] forecast in
            DispatchQueue.main.async {
                self?.updateViewWith(forecast: forecast)
            }
        }
        
        viewModel.outputs.isBussy.bind { [weak self] isBussy in
            guard let weakSelf = self else { return }
            DispatchQueue.main.async {
                if isBussy {
                    weakSelf.showSpinner()
                } else {
                    weakSelf.hideSpinner()
                }
            }
        }
        
        viewModel.outputs.error.bind { _ in }
    }
}
