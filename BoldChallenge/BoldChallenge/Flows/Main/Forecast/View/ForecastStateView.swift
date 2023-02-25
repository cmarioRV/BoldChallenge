//
//  ForecastStateView.swift
//  BoldChallenge
//
//  Created by Mario Rúa on 25/02/23.
//

import Foundation
import Domain
import UIKit

class ForecastStateView: UIView {
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .center
        stack.axis = .horizontal
        stack.spacing = 5
        stack.distribution = .fillEqually
        return stack
    }()
    
    private var icons: [Date:UIImage] = [:]
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureViews() {
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    public func configure(with viewModel: ViewModel) {
        let relativeDateFormatter = DateFormatter()
        relativeDateFormatter.timeStyle = .none
        relativeDateFormatter.dateStyle = .medium
        relativeDateFormatter.locale = Locale(identifier: "en_EN")
        relativeDateFormatter.doesRelativeDateFormatting = true
        
        let forecasts = viewModel.forecasts.filter{ $0.date != nil }.sorted(by: { $0.date! < $1.date! })
        
        let group = DispatchGroup()
        forecasts.forEach { day in
            if let iconUrlString = day.stateIcon,
               let iconUrl = URL(string: iconUrlString) {
                group.enter()
                URLSession.shared.dataTask(with: iconUrl) { [weak self] data, _, error in
                    defer { group.leave() }
                    if error == nil, let data = data, let image = UIImage(data: data) {
                        self?.icons[day.date!] = image
                    }
                }.resume()
            }
        }
        
        group.notify(queue: .main) { [weak self] in
            self?.icons.sorted(by: { $0.key < $1.key }).forEach({ date, image in
                let dayStackView = UIStackView()
                dayStackView.axis = .vertical
                dayStackView.distribution = .equalCentering
                dayStackView.spacing = 5
                dayStackView.alignment = .center
                
                let titleLabel = UILabel()
                titleLabel.numberOfLines = 0
                titleLabel.textAlignment = .center
                titleLabel.font = .systemFont(ofSize: 12, weight: .medium)
                titleLabel.text = relativeDateFormatter.string(from: date)
                
                let imageView = UIImageView(image: image)
                imageView.contentMode = .scaleAspectFit
                
                dayStackView.addArrangedSubview(titleLabel)
                dayStackView.addArrangedSubview(imageView)
                self?.stackView.addArrangedSubview(dayStackView)
                self?.setNeedsLayout()
            })
        }
    }
}

extension ForecastStateView {
    struct ViewModel {
        let forecasts: [ForecastDay]
    }
}
