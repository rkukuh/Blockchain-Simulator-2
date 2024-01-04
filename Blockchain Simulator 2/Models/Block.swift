//
//  Block.swift
//  Blockchain Simulator 2
//
//  Created by R. Kukuh on 03/01/24.
//

import Foundation

struct Block {
    var nonce: Int = 0
    var data: String = ""
    var hash: String = ""
    var isMining: Bool = false
    var difficulty: Int = 4
    var isHashCorrect: Bool = false
}
