//
//  HashView.swift
//  Blockchain Simulator 2
//
//  Created by R. Kukuh on 03/01/24.
//

import SwiftUI

struct HashView: View {
    @ObservedObject var viewModel = HashViewModel()

    var body: some View {
        VStack {
            TextEditor(text: $viewModel.hash.inputText)
                .frame(minHeight: 100)
                .padding()
                .onChange(of: viewModel.hash.inputText) {
                    viewModel.updateHash()
                }

            Picker("Algorithm", selection: $viewModel.hash.selectedAlgorithm) {
                Text("SHA256").tag(HashAlgorithm.sha256)
                Text("SHA512").tag(HashAlgorithm.sha512)
            }
            .pickerStyle(SegmentedPickerStyle())
            .onChange(of: viewModel.hash.selectedAlgorithm) { 
                viewModel.updateHash()
            }

            GroupBox(label: Text("Hashed Result")) {
                Text(viewModel.hash.hashedText)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding()
        .navigationTitle("Hash")
    }
}

#Preview {
    HashView()
}
