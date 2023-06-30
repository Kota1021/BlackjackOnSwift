//
//  DealerHandView.swift
//  TCABlackJack
//
//  Created by 松本幸太郎 on 2023/06/28.
//

import SwiftUI
import SwiftyBlackjack

struct DealerHandView: View {
    let dealer: Blackjack.Dealer

    init(of dealer: Blackjack.Dealer){
        self.dealer = dealer
    }
    
    var body: some View {
        VStack{
            Text(dealer.hasFlippedSecondCard ? "\(dealer.points)" : "?")
                .font(.headline)
                .fontWeight(.black)
                .foregroundColor(dealer.isBust ? .red : .primary)
            HStack{
                ForEach(dealer.hand) { card in
                    CardView(card)
                }
            }
            .padding()
            .overlay{
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.gray)
            }
        }
    }
}

struct DealerHandView_Previews: PreviewProvider {
    static var previews: some View {
        DealerHandView(of: PreviewData.dealer)
    }
}
