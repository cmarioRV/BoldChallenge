//
//  SearchTableViewCell.swift
//  BoldChallenge
//
//  Created by Mario Rúa on 24/02/23.
//

import Foundation
import UIKit

class SearchTableViewCell: UITableViewCell, CellConfigurable {
    var viewModel: ViewModel?
    
    let containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    let textStackView: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .leading
        stack.axis = .vertical
        stack.spacing = 5
        stack.distribution = .fillEqually
        return stack
    }()
    
    let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 1
        lbl.textAlignment = .left
        lbl.font = .preferredFont(forTextStyle: .body)
        lbl.textColor = .black
        return lbl
    }()
    
    let bodyLabel: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 1
        lbl.textAlignment = .left
        lbl.font = .preferredFont(forTextStyle: .headline)
        lbl.textColor = .black
        return lbl
    }()
    
    let arrowImageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "nextIcon"))
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureContents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func configureContents() {
        contentView.addSubview(containerView)
        containerView.addSubview(textStackView)
        containerView.addSubview(arrowImageView)
        textStackView.addArrangedSubview(titleLabel)
        textStackView.addArrangedSubview(bodyLabel)
        
        let guides = contentView.safeAreaLayoutGuide
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: guides.leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: guides.trailingAnchor, constant: -20),
            containerView.topAnchor.constraint(equalTo: guides.topAnchor, constant: 5),
            containerView.bottomAnchor.constraint(equalTo: guides.bottomAnchor, constant: -5)
        ])
        
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            arrowImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            arrowImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12),
            arrowImageView.heightAnchor.constraint(equalToConstant: 16),
            arrowImageView.widthAnchor.constraint(equalToConstant: 16)
        ])
        
        textStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15),
            textStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15),
            textStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            textStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12)
        ])
        
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.init(white: 0, alpha: 0.1).cgColor
        containerView.layer.cornerRadius = 15
        
        contentView.layoutIfNeeded()
    }
    
    func configure(viewModel: CellViewModel) {
        guard let viewModel = viewModel as? ViewModel else { return }
        self.viewModel = viewModel
        titleLabel.text = viewModel.locationName
        bodyLabel.text = viewModel.countryName
    }
}

extension SearchTableViewCell {
    struct ViewModel: CellViewModel {
        let locationName: String
        let countryName: String
    }
}
