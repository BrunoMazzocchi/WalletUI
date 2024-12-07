//
//  Card.swift
//  WalletUI
//
//  Created by Bruno Mazzocchi on 6/12/24.
//

import SwiftUI

struct Card: Identifiable {
    var id: String = UUID().uuidString
    var number: String
    var expires: String
    var color: Color
}

var cards: [Card] = [
    .init(number: "**** **** **** 1234", expires: "06/21", color: .blue),
    .init(number: "**** **** **** 5678", expires: "01/24", color: .pink),
    .init(number: "**** **** **** 9648", expires: "09/26", color: .indigo)
]
