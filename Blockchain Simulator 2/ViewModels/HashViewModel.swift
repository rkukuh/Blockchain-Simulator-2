//
//  HashViewModel.swift
//  Blockchain Simulator 2
//
//  Created by R. Kukuh on 04/01/24.
//

import Foundation
import CryptoKit

class HashViewModel: ObservableObject {
    @Published var hash = Hash()

    func updateHash() {
        switch hash.selectedAlgorithm {
        case .sha256:
            hash.hashedText = SHA256.hash(data: Data(hash.inputText.utf8)).compactMap {
                String(format: "%02x", $0)
            }.joined()
        case .sha512:
            hash.hashedText = SHA512.hash(data: Data(hash.inputText.utf8)).compactMap {
                String(format: "%02x", $0)
            }.joined()
        }
    }
}
