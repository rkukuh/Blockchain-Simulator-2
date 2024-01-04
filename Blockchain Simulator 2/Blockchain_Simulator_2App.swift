//
//  Blockchain_Simulator_2App.swift
//  Blockchain Simulator 2
//
//  Created by R. Kukuh on 03/01/24.
//

import SwiftUI

@main
struct Blockchain_Simulator_2App: App {
    var body: some Scene {
        WindowGroup {
            MainView()
                .frame(minWidth: 600, maxWidth: .infinity,
                       minHeight: 500, maxHeight: .infinity)
        }
    }
}
