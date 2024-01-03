//
//  BlockView.swift
//  Blockchain Simulator 2
//
//  Created by R. Kukuh on 03/01/24.
//

import SwiftUI
import CryptoKit

struct BlockView: View {
    @State private var nonce: Int = Int.random(in: 0..<1000)
    @State private var data: String = ""
    @State private var hashResult: String = ""
    @State private var isMining: Bool = false

    var body: some View {
        VStack {
            Text("Nonce: \(nonce)")
                .padding()

            VStack(alignment: .leading) {
                Text("Data")
                TextEditor(text: $data)
                    .frame(minHeight: 100)
                    .onChange(of: data) { updateHash() }
                    .border(Color.gray, width: 1)
            }
            .padding()

            Text("Hash: \(hashResult)")
                .padding()

            if isMining {
                ProgressView("Mining in process")
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()
            } else {
                Button("Start Mining") {
                    startMining()
                }
                .padding()
            }
        }
        .padding()
        .background(isMining ? Color.green.opacity(0.5) : Color.red.opacity(0.5))
        .navigationTitle("Block")
        .onAppear(perform: updateHash)
    }

    private func updateHash() {
        let textToHash = "\(nonce)\(data)"
        hashResult = SHA256.hash(data: Data(textToHash.utf8)).compactMap { String(format: "%02x", $0) }.joined()
        isMining = false
    }

    private func startMining() {
        isMining = true

        // Run mining in background to prevent UI freezing
        DispatchQueue.global(qos: .userInitiated).async {
            self.mineBlock()
            DispatchQueue.main.async {
                self.isMining = false
            }
        }
    }

    private func mineBlock() {
        nonce = 0
        var found = false
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
