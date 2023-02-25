//
//  CellViewModel.swift
//  BoldChallenge
//
//  Created by Mario Rúa on 24/02/23.
//

import Foundation

protocol CellViewModel {}

protocol ViewModelPressible {
    var cellPressed: (()->Void)? { get set }
}
