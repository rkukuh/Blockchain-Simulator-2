//
//  Hash.swift
//  Blockchain Simulator 2
//
//  Created by R. Kukuh on 04/01/24.
//

import Foundation

struct Hash {
    var inputText: String = ""
    var selectedAlgorithm: HashAlgorithm = .sha256
    var hashedText: String = ""
}
