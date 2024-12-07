//
//  DetailView.swift
//  WalletUI
//
//  Created by Bruno Mazzocchi on 6/12/24.
//

import SwiftUI


struct DetailView: View {
    var selectedCard: Card

    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 12) {
                ForEach(sampleTransactions, id: \.id) { transaction in
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Amount: \(transaction.amount)")
                                .font(.headline)
                                .foregroundColor(.primary)
                            Text("Date: \(transaction.date)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Text("Account: \(transaction.account)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color(UIColor.systemGray5))
                    )
                    .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                }
            }
            .padding()
        }
    }
}
#Preview {
    ContentView()
}
