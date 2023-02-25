//
//  CellConfigurable.swift
//  BoldChallenge
//
//  Created by Mario Rúa on 24/02/23.
//

import Foundation

protocol CellConfigurable {
    func configure(viewModel: CellViewModel)
}

extension CellConfigurable {
    static func cellIdentifier() -> String {
        return String(describing: self)
    }
}
