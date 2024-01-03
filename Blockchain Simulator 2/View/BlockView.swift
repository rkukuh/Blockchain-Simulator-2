//
//  BlockView.swift
//  Blockchain Simulator 2
//
//  Created by R. Kukuh on 03/01/24.
//

import SwiftUI
import CryptoKit

struct BlockView: View {
    @State private var nonce: String = "0"
    @State private var data: String = "Satoshi acquire 100 BTC"
    @State private var hashResult: String = ""
    @State private var isMining: Bool = false
    @State private var difficulty: Int = 4
    @State private var selectedAlgorithm: HashAlgorithm = .sha256
    @State private var isHashCorrect: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Text("Nonce")
                TextField("Nonce", text: $nonce)
                    .padding()
            }
            
            VStack(alignment: .leading) {
                Text("Data")
                TextEditor(text: $data)
                    .frame(minHeight: 100)
                    .onChange(of: data) { updateHash() }
                    .border(Color.gray, width: 1)
            }
            
            Picker("Algorithm", selection: $selectedAlgorithm) {
                Text("SHA256").tag(HashAlgorithm.sha256)
                Text("SHA512").tag(HashAlgorithm.sha512)
            }
            .pickerStyle(SegmentedPickerStyle())
            .onChange(of: selectedAlgorithm) { updateHash() }
            
            Picker("Difficulty", selection: $difficulty) {
                Text("3 Zeros").tag(3)
                Text("4 Zeros").tag(4)
                Text("5 Zeros").tag(5)
            }
            .pickerStyle(SegmentedPickerStyle())
            
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
            
            GroupBox(label: Text("Hashed Result")) {
                Text(hashResult)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding()
        .background(isHashCorrect ? Color.green.opacity(0.5) : Color.red.opacity(0.5))
        .navigationTitle("Block")
        .onAppear(perform: updateHash)
    }
    
    private func updateHash() {
        let textToHash = "\(nonce)\(data)"
        hashResult = computeHash(input: textToHash, algorithm: selectedAlgorithm)
        isMining = false
        checkHashResult()
    }
    
    private func startMining() {
        isMining = true
        DispatchQueue.global(qos: .userInitiated).async {
            self.mineBlock()
        }
    }
    
    private func mineBlock() {
        var nonceValue = Int(nonce) ?? 0
        var found = false
        while !found {
            let textToHash = "\(nonceValue)\(data)"
            let hash = computeHash(input: textToHash, algorithm: selectedAlgorithm)
            if hash.hasPrefix(String(repeating: "0", count: difficulty)) {
                found = true
                hashResult = hash
                DispatchQueue.main.async {
                    self.nonce = String(nonceValue)
                    self.isMining = false
                    self.checkHashResult()
                }
            } else {
                nonceValue += 1
            }
        }
    }
    
    private func checkHashResult() {
        if hashResult.hasPrefix(String(repeating: "0", count: difficulty)) {
            isHashCorrect = true
        } else {
            isHashCorrect = false
        }
    }
    
    private func computeHash(input: String, algorithm: HashAlgorithm) -> String {
        switch algorithm {
        case .sha256:
            return SHA256.hash(data: Data(input.utf8)).compactMap { String(format: "%02x", $0) }.joined()
        case .sha512:
            return SHA512.hash(data: Data(input.utf8)).compactMap { String(format: "%02x", $0) }.joined()
        }
    }
}

#Preview {
    BlockView()
}
