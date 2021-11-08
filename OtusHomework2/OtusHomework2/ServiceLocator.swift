//
//  ServiceLocator.swift
//  OtusHomework2
//
//  Created by Daria.S on 07.11.2021.
//

import Foundation

class ServiceLocator : NSObject {
    private var containerServices = [String: AnyObject]()
    
    func addService<T:AnyObject>(service: T) {
        let key = "\(T.self)"
        if containerServices[key] == nil {
            containerServices[key] = service
        }
    }
    
    func getService<T:AnyObject>(type: T.Type)->T? {
        let key = "\(T.self)"
        return containerServices[key] as? T
    }
}
