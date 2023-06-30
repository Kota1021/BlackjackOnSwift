//
//  Dealer.swift
//  TCABlackJack
//
//  Created by 松本幸太郎 on 2023/06/21.
//

import SwiftyBlackJack

//struct Dealer{
//    public var game: BlackJack
//    private(set) var playState: PlayState
//    internal var playerCounts:Int
//
//    init(game: BlackJack = BlackJack(),playerCounts:Int = 1) {
//        self.game = game
//        self.playState = .drawCardToPlayer(ofIndex: 0)
//        self.playerCounts = playerCounts
//    }
//
//    mutating public func startToPlay(){
//        //MARK: first deal each participants two cards.
//        for index in 0..<playerCounts{
//            playState = .drawCardToPlayer(ofIndex: index)
//            game.dealToPlayer(ofIndex: index, isFaceUp: true)
//        }
//
//        playState = .drawCardToDealer
//        game.dealToDealer(isFaceUp: false)
//
//        for index in 0..<playerCounts{
//            playState = .drawCardToPlayer(ofIndex: index)
//            game.dealToPlayer(ofIndex: index, isFaceUp: true)
//        }
//
//        playState = .drawCardToDealer
//        game.dealToDealer(isFaceUp: true)
//
//        //MARK: checkIfSomeoneBusted
//        playState = .checkIfSomeoneBusted
//        //-------------------------
//        //-------------------------
//        //-------------------------
//
//        //MARK: players turn
//        playState = .waitingForPlayers
//    }
//
//    mutating private func dealersTurn(){
//        playState = .dealersTrun
//        while game.dealer.needsToDrawToItself{
//            game.dealToDealer()
//            if game.dealer.isBust{
//                playState = .concludeGame
//                self.conclude()
//                return
//            }
//        }
//        self.conclude()
//    }
//
//    mutating private func conclude(){
//        playState = .concludeGame
////        var bustParticipants =
//    }
//}

//extension Dealer{
//    /// PlayState indicates what Dealer is going to do next
//    enum PlayState{
//        case drawCardToPlayer(ofIndex:Int)
//        case drawCardToDealer
////        case drawFirstCardToPlayer
////        case drawFirstCardToDealer
////        case drawSecondCardToPlayer
////        case drawSecondCardToDealer
//        case checkIfSomeoneBusted
//        case waitingForPlayers
//        case dealersTrun
//        case concludeGame
//    }
//}

