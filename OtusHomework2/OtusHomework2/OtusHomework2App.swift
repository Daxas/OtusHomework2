//
//  OtusHomework2App.swift
//  OtusHomework2
//
//  Created by Daria.S on 16.10.2021.
//

import SwiftUI
import UIKit

@main
struct OtusHomework2App: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(Router())
                .onAppear {
                    Configurator.shared.setup()
                }
        }
    }
}
