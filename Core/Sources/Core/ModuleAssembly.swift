//
//  File.swift
//  
//
//  Created by Mario Rúa on 24/02/23.
//

import Foundation
import Swinject

public protocol ModuleAssemblyDelegate {
    func loadedAssemblies(resolver: Resolver)
}

public protocol ModuleAssembly: Assembly {
    var delegate: ModuleAssemblyDelegate? { get set }
}
