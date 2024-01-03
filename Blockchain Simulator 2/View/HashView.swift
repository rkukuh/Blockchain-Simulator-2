//
//  HashView.swift
//  Blockchain Simulator 2
//
//  Created by R. Kukuh on 03/01/24.
//

import SwiftUI
import CryptoKit

struct HashView: View {
    @State private var inputText: String = ""
    @State private var selectedAlgorithm: HashAlgorithm = .sha256
    @State private var hashedText: String = ""
    
    var body: some View {
        VStack {
            TextEditor(text: $inputText)
                .frame(minHeight: 100)
                .padding()
            Picker("Algorithm", selection: $selectedAlgorithm) {
                Text("SHA256").tag(HashAlgorithm.sha256)
                Text("SHA512").tag(HashAlgorithm.sha512)
            }
            .pickerStyle(SegmentedPickerStyle())
            Button("Hash It!") {
                hashInput()
            }
            Text(hashedText)
        }
        .padding()
        .navigationTitle("Hash")
    }
    
    private func hashInput() {
        switch selectedAlgorithm {
        case .sha256:
            hashedText = SHA256.hash(data: Data(inputText.utf8)).compactMap { String(format: "%02x", $0) }.joined()
        case .sha512:
            hashedText = SHA512.hash(data: Data(inputText.utf8)).compactMap { String(format: "%02x", $0) }.joined()
        }
    }
}

#Preview {
    HashView()
}
