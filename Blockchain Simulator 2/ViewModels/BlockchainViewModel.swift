//
//  BlockchainViewModel.swift
//  Blockchain Simulator 2
//
//  Created by R. Kukuh on 04/01/24.
//

import Foundation
import CryptoKit

class BlockchainViewModel: ObservableObject {
    @Published var blockchain = [Block]()

    init() {
        // Initialize the blockchain with a genesis block
        let genesisBlock = Block(index: 0, nonce: 0, data: "Genesis Block", hash: "", previousHash: "0000")
        var mutableGenesisBlock = genesisBlock
        mutableGenesisBlock.hash = computeHash(for: mutableGenesisBlock, nonce: genesisBlock.nonce)
        blockchain.append(mutableGenesisBlock)
    }

    func addBlock(data: String) {
        let newIndex = blockchain.count
        let previousHash = blockchain.last?.hash ?? "0000"
        let newBlock = Block(index: newIndex, data: data, previousHash: previousHash)
        blockchain.append(newBlock)
        updateHash(for: &blockchain[newIndex])
    }

    private func updateHash(for block: inout Block) {
        var nonce = 0
        var hash: String
        repeat {
            hash = computeHash(for: block, nonce: nonce)
            nonce += 1
        } while !hash.hasPrefix(String(repeating: "0", count: block.difficulty))
        block.hash = hash
        block.nonce = nonce - 1
    }

    private func computeHash(for block: Block, nonce: Int) -> String {
        let inputData = "\(nonce)\(block.index)\(block.data)\(block.previousHash)".data(using: .utf8)!
        let hashedData = SHA256.hash(data: inputData)
        return hashedData.compactMap { String(format: "%02x", $0) }.joined()
    }
}
