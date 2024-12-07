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
    var totalAmount: Double
    
    var visaGeometryID: String {
        "VISA \(id)"
    }
}

var cards: [Card] = [
    .init(number: "**** **** **** 1234", expires: "06/21", color: .blue, totalAmount: 341.45),
    .init(number: "**** **** **** 5678", expires: "01/24", color: .pink, totalAmount: 500.00),
    .init(number: "**** **** **** 9648", expires: "09/26", color: .indigo, totalAmount: 000.00),
    .init(number: "**** **** **** 9618", expires: "09/25", color: .black, totalAmount: 123.45)
]
