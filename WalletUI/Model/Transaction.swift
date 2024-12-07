//
//  Transaction.swift
//  WalletUI
//
//  Created by Bruno Mazzocchi on 6/12/24.
//

import SwiftUI

struct Transaction: Identifiable {
    let id = UUID()
    let amount: String
    let date: String
    let account: String
}

var sampleTransactions = [
    Transaction(amount: "$20.04", date: "2024-06-15", account: "**** **** **** 3424"),
    Transaction(amount: "$45.99", date: "2024-06-14", account: "**** **** **** 1234"),
    Transaction(amount: "$120.50", date: "2024-06-12", account: "**** **** **** 5678"),
    Transaction(amount: "$9.99", date: "2024-06-10", account: "**** **** **** 4321")
]
