//
//  BlockView.swift
//  Blockchain Simulator 2
//
//  Created by R. Kukuh on 03/01/24.
//

import SwiftUI
import CryptoKit

struct BlockView: View {
    @State private var nonce: Int = 0
    @State private var data: String = ""
    @State private var hashResult: String = ""
    
    var body: some View {
        VStack {
            Text("Nonce: \(nonce)")
                .padding()

            TextEditor(text: $data)
                .frame(minHeight: 100)
                .padding()

            Text("Hash: \(hashResult)")
                .padding()

            Button("Mine") {
                mineBlock()
            }
            .padding()
        }
        .navigationTitle("Block")
    }

    private func mineBlock() {
        var found = false
        nonce = 0
        while !found {
            let textToHash = "\(nonce)\(data)"
            let hash = SHA256.hash(data: Data(textToHash.utf8)).compactMap { String(format: "%02x", $0) }.joined()
            if hash.hasPrefix("0000") {
                found = true
                hashResult = hash
            } else {
                nonce += 1
            }
        }
    }
}

#Preview {
    BlockView()
}
