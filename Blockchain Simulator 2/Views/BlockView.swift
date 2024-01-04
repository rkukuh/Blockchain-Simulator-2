//
//  BlockView.swift
//  Blockchain Simulator 2
//
//  Created by R. Kukuh on 03/01/24.
//

import SwiftUI

struct BlockView: View {
    @ObservedObject var viewModel: BlockViewModel
    @State private var selectedAlgorithm: HashAlgorithm = .sha256
    
    init(viewModel: BlockViewModel = BlockViewModel(block: Block())) {
        self.viewModel = viewModel
        viewModel.block.data = "Satoshi acquire 100 BTC"
    }

    var body: some View {
        VStack {
            HStack {
                Text("Nonce")
                TextField("Nonce", value: $viewModel.block.nonce, formatter: NumberFormatter())
                    .padding()
            }
            
            VStack(alignment: .leading) {
                Text("Data")
                TextEditor(text: $viewModel.block.data)
                    .frame(minHeight: 100)
                    .onChange(of: viewModel.block.data) {
                        viewModel.updateHash(algorithm: selectedAlgorithm)
                    }
                    .border(Color.gray, width: 1)
            }
            
            Picker("Algorithm", selection: $selectedAlgorithm) {
                Text("SHA256").tag(HashAlgorithm.sha256)
                Text("SHA512").tag(HashAlgorithm.sha512)
            }
            .pickerStyle(SegmentedPickerStyle())
            .onChange(of: selectedAlgorithm) {
                viewModel.updateHash(algorithm: selectedAlgorithm)
            }
            
            Picker("Difficulty", selection: $viewModel.block.difficulty) {
                Text("3 Zeros").tag(3)
                Text("4 Zeros").tag(4)
                Text("5 Zeros").tag(5)
            }
            .pickerStyle(SegmentedPickerStyle())
            
            if viewModel.block.isMining {
                ProgressView("Mining in process")
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()
            } else {
                Button("Start Mining") {
                    viewModel.mineBlock(algorithm: selectedAlgorithm)
                }
                .padding()
            }
            
            if viewModel.showPreviousHash {
                GroupBox(label: Text("Previous Hash")) {
                    Text(viewModel.block.previousHash)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            
            GroupBox(label: Text("Hashed Result")) {
                Text(viewModel.block.hash)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding()
        .background(
            viewModel.block.isHashCorrect ? Color.green.opacity(0.5) : Color.red.opacity(0.5)
        )
        .navigationTitle("Block")
        .onAppear {
            viewModel.updateHash(algorithm: selectedAlgorithm)
        }
    }
}

#Preview {
    BlockView()
}
