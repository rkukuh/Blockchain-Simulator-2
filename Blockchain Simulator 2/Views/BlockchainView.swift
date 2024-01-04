//
//  BlockchainView.swift
//  Blockchain Simulator 2
//
//  Created by R. Kukuh on 04/01/24.
//

import SwiftUI

struct BlockchainView: View {
    @ObservedObject var viewModel = BlockchainViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.blockchain, id: \.index) { block in
                    BlockView(viewModel: BlockViewModel(block: block))
                }
            }
            .padding()
        }
        .navigationTitle("Blockchain")
        .toolbar {
            ToolbarItem(placement: .automatic) {
                Button(action: {
                    let newData = "Data \(viewModel.blockchain.count)"
                    viewModel.addBlock(data: newData)
                }) {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

#Preview {
    BlockchainView()
}
