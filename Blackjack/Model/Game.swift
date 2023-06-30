//
//  GameStateManager.swift
//  TCABlackJack
//
//  Created by 松本幸太郎 on 2023/06/23.
//

//import SwiftyBlackJack
//
//struct Game{
//    private var game:BlackJack
//    public private(set) var currentState: CurrentState
//    public var dealer: BlackJack.Dealer{ game.dealer }
//    public var players: [BlackJack.Player]{ game.players }
//
//    mutating public func dealCard(toPlayerIndexOf index: Int){
//        currentState = .dealingCardToPlayer(ofIndex: index)
//        game.dealCard(toPlayerIndexOf: index)
//    }
//    mutating public func dealCardToDealer(isFaceUp: Bool = true){
//        currentState = .dealingCardToDealer
//        game.dealCardToDealer(isFaceUp: isFaceUp)
//    }
//    mutating public func flipDealersSecondCard(){
//        currentState = .flippingDealersSecondCard
//        game.flipDealersSecondCard()
//    }
//
//    init(numberOfPlayers:Int = 1) {
//        self.game = BlackJack(numberOfPlayers: numberOfPlayers)
//        currentState = .dealingCardToPlayer(ofIndex: 0)
//    }
//}
//
//
//extension Game{
//    public mutating func conclude(){
//        if dealer.isBust{
//            let result = BlackJack.GameResult.winners( players.filter { !$0.isBust } )
//            currentState = .over(result)
//        }else{
//            let dealersGapFrom21: Int = 21 - dealer.points
//            let winningPlayers: [BlackJack.Player] = players.filter { !$0.isBust && (21 - $0.points < dealersGapFrom21)}
//            if winningPlayers.isEmpty{
//                let result = BlackJack.GameResult.winners( [dealer] )
//                currentState = .over(result)
//            }else{
//                let result = BlackJack.GameResult.winners(winningPlayers)
//                currentState = .over(result)
//            }
//        }
//    }
//
//}
//
//
//extension Game{
//    enum CurrentState:CustomStringConvertible{
//        case dealingCardToPlayer(ofIndex:Int)
//        case dealingCardToDealer
//        case flippingDealersSecondCard
//        case over(BlackJack.GameResult)
//
//        var description: String{
//            switch self {
//            case .dealingCardToPlayer:
//                return "drawCardToPlayer"
//            case .dealingCardToDealer:
//                return "drawCardToDealer"
//            case .flippingDealersSecondCard:
//                return "flippingDealersCard"
//            case .over:
//                return "gameOver"
//            }
//        }
//
//    }
//}
