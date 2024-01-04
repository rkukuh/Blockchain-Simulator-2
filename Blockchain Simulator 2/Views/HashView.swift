//
//  HashView.swift
//  Blockchain Simulator 2
//
//  Created by R. Kukuh on 03/01/24.
//

import SwiftUI
import CryptoKit

struct HashView: View {
    @State private var inputText: String = "You may change this text and see for yourself."
    @State private var selectedAlgorithm: HashAlgorithm = .sha256
    @State private var hashedText: String = ""
    
    var body: some View {
        VStack {
            TextEditor(text: $inputText)
                .frame(minHeight: 100)
                .onChange(of: inputText) { 
                    updateHash()
                }
            
            Picker("Algorithm", selection: $selectedAlgorithm) {
                Text("SHA256").tag(HashAlgorithm.sha256)
                Text("SHA512").tag(HashAlgorithm.sha512)
            }
            .pickerStyle(SegmentedPickerStyle())
            .onChange(of: selectedAlgorithm) {
                updateHash()
            }
            
            GroupBox(label: Text("Hashed Result")) {
                Text(hashedText)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding()
        .navigationTitle("Hash")
        .onAppear(perform: updateHash)
    }
    
    private func updateHash() {
        hashedText = hash(input: inputText, algorithm: selectedAlgorithm)
    }
    
    private func hash(input: String, algorithm: HashAlgorithm) -> String {
        switch algorithm {
        case .sha256:
            return SHA256.hash(data: Data(input.utf8)).compactMap { String(format: "%02x", $0) }.joined()
        case .sha512:
            return SHA512.hash(data: Data(input.utf8)).compactMap { String(format: "%02x", $0) }.joined()
        }
    }
}

#Preview {
    HashView()
}
