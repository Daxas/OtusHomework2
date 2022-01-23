//
//  Configurator.swift
//  OtusHomework2
//
//  Created by Daria.S on 07.11.2021.
//

import Foundation

class Configurator {
    static let shared = Configurator()
    let serviceLocator = ServiceLocator()
    
    func setup() {
        registerServices()
    }
    
   private func registerServices() {
       serviceLocator.addService(service: NetworkService())
       serviceLocator.addService(service: RepositoryService())
    }
}
