//
//  Block.swift
//  Blockchain Simulator 2
//
//  Created by R. Kukuh on 03/01/24.
//

import Foundation

struct Block {
    var index: Int = 0
    var nonce: Int = 0
    var data: String = ""
    var hash: String = ""
    var previousHash: String = "0000"
    var isMining: Bool = false
    var difficulty: Int = 4
    var isHashCorrect: Bool = false
}
