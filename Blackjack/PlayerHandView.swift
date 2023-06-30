//
//  HandView.swift
//  TCABlackJack
//
//  Created by 松本幸太郎 on 2023/06/23.
//

import SwiftUI
import SwiftyBlackjack

struct PlayerHandView: View {
    let player: Blackjack.Player
    let isTurn: Bool
    
    init(of player: Blackjack.Player, isTurn: Bool){
        self.player = player
        self.isTurn = isTurn
    }

    var body: some View {
        VStack{
            Text("\(player.points)")
                .font(.headline)
                .fontWeight(.black)
                .foregroundColor(player.isBust ? .red : .primary)
            HStack{
                ForEach(player.hand) { card in
                    CardView(card)
                }
            }
            .padding()
            .overlay{
                RoundedRectangle(cornerRadius: 8)
                    .stroke(isTurn ? Color.accentColor : .gray)
            }
        }
    }
}

struct HandView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerHandView(of: PreviewData.player, isTurn: true)
    }
}
