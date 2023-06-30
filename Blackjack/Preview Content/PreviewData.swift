//
//  PreviewData.swift
//  TCABlackJack
//
//  Created by 松本幸太郎 on 2023/06/28.
//

import SwiftyBlackjack

struct PreviewData{
    static let card0 = Card(face: .init(rank: .ace, suit: .spade))
    static let card1 = Card(face: .init(rank: .two, suit: .heart))

    static let player = Blackjack.Player(name: "0", hand: [card0,card1])
    static let dealer = Blackjack.Dealer(hand: [card0,card1])
}
