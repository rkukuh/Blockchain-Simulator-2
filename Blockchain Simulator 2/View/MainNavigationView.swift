//
//  ContentView.swift
//  Blockchain Simulator 2
//
//  Created by R. Kukuh on 03/01/24.
//

import SwiftUI

struct MainNavigationView: View {
    @State private var selectedMenuItem: MenuItem? = .hash
    
    var body: some View {
        NavigationSplitView {
            List(MenuItem.allCases, id: \.self, selection: $selectedMenuItem) { item in
                Text(item.rawValue)
            }
            .navigationTitle("Topics")
        } detail: {
            if let selectedMenuItem = selectedMenuItem {
                switch selectedMenuItem {
                case .hash:
                    HashView()
                case .block:
                    BlockView()
                case .blockchain:
                    Text("Blockchain View")
                case .distributed:
                    Text("Distributed View")
                case .tokens:
                    Text("Tokens View")
                case .coinbase:
                    Text("Coinbase View")
                }
            } else {
                Text("Select a topic")
            }
        }
    }
}

#Preview {
    MainNavigationView()
}
