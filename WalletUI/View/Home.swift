//
//  Home.swift
//  WalletUI
//
//  Created by Bruno Mazzocchi on 6/12/24.
//

import SwiftUI

struct Home: View {
    // MARK: - Properties
    var size: CGSize
    var safeArea: EdgeInsets
    
    // MARK: - State View Properties
    @State private var showDetailView: Bool = false
    @State private var selectedCard: Card?
    @Namespace private var animation
    
    // MARK: - Body
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack (spacing: 0) {
                Text("My Wallet")
                    .font(.title2.bold())
                    .frame(maxWidth: .infinity)
                    .overlay(alignment: .trailing) {
                        Button {
                            
                        } label: {
                            Image(.pic)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 35, height: 35)
                                .clipShape(.circle)
                        }
                    }
                    .blur(radius: showDetailView ? 5 : 0)
                    .opacity(showDetailView ? 0 : 1)
                
                // MARK: - Cards View
                
                let mainOffset = CGFloat(cards.firstIndex(where: { $0.id == selectedCard?.id }) ?? 0) * -size.width
                VStack(spacing: 10) {
                    ForEach(cards) { card in
                        // Converts this scrollview to horizontal without changing any of
                        // it's properties and by just using the offset modifier
                        let cardOffset = CGFloat(cards.firstIndex(where: { $0.id == card.id}) ?? 0) * size.width
                        CardView(card)
                        // Making it occupy the full screen width conditionally
                            .frame(width: showDetailView ? size.width : nil)
                        // Moving all cards to the top conditionally using offset
                            .visualEffect { [showDetailView] content, proxy in
                                content
                                    .offset(x: showDetailView ? cardOffset : 0, y: showDetailView ? -proxy.frame(in: .scrollView).minY : 0)
                            }
                    }
                }
                .padding(.top, 25)
                .offset(x: showDetailView ? mainOffset : 0)
                
            }
            // The reason for not modifying the main view's frame is to preserve it's
            // scroll position when it's coming back from detail view to the home view
            .safeAreaPadding(15)
            .safeAreaPadding(.top, safeArea.top)
        }
        .scrollDisabled(showDetailView)
        .scrollIndicators(.hidden)
        .overlay {
            if let selectedCard, showDetailView {
                DetailView(selectedCard: selectedCard)
                    .padding(.top, expandedCardHeight)
                    .transition(.move(edge: .bottom))
            }
        }
    }
    
    // MARK: - Card View Builder
    @ViewBuilder
    func CardView(_ card: Card) -> some View {
        ZStack {
            Rectangle()
                .fill(card.color.gradient)
            
            // Card details
            VStack (alignment: .leading, spacing: 15) {
                if !showDetailView {
                    VisaImageView(card.visaGeometryID, height: 50)
                }
                
                VStack (alignment: .leading, spacing: 4) {
                    Text(card.number)
                        .font(.caption)
                        .foregroundStyle(.white.secondary)
                    
                    Text(String(format: "$%.2f", card.totalAmount))
                        .font(.title2.bold())
                        .foregroundStyle(.white)
                }
                /// Making it to center when the card is expanded
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: showDetailView ? .center: .leading)
                .overlay {
                    ZStack {
                        if showDetailView {
                            VisaImageView(card.visaGeometryID, height: 40)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .offset(y: 28)
                        }
                        
                        // Visible only for the selected card
                        if let selectedCard, selectedCard.id == card.id, showDetailView {
                            Button {
                                withAnimation (.smooth (duration: 0.5, extraBounce: 0)) {
                                    self.selectedCard = nil
                                    showDetailView = false
                                }
                            } label: {
                                Image(systemName: "chevron.left")
                                    .font(.title3.bold())
                                    .foregroundStyle(.white)
                                    .contentShape(.rect)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .transition(.asymmetric(insertion: .opacity, removal: .identity))
                        }
                    }
                }
                .padding(.top, showDetailView ? safeArea.top + 10 : 0)
                
                HStack {
                    Text("Expires: \(card.expires)")
                        .font(.caption)
                    
                    Spacer()
                    
                    Text("John Doe")
                        .font(.callout)
                }
                .foregroundStyle(.white.secondary)
            }
            .padding(showDetailView ? 15 : 25)
        }
        // Modify the card's height for the detail view
        .frame(height: showDetailView ? 130 : nil)
        /// The reason for this is unchanged, because it preserves the scroll position of the parent view
        /// when coming back from the detail view to the home view!
        .frame(height: 200, alignment: .top)
        .clipShape(.rect(cornerRadius: showDetailView ? 0 : 25))
        .onTapGesture {
            /// Close with the back button
            ///
            guard !showDetailView else { return }
            withAnimation (.smooth(duration: 0.5, extraBounce: 0)) {
                selectedCard = card
                showDetailView = true
            }
        }
    }
    
    // MARK: - Visa Image View
    @ViewBuilder
    func VisaImageView(_ id: String, height: CGFloat) -> some View {
        Image(.visa)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .matchedGeometryEffect(id: id, in: animation)
            .frame(height: height)
        
    }
    
    var expandedCardHeight: CGFloat {
        safeArea.top + 130
    }
}

#Preview {
    ContentView()
}
