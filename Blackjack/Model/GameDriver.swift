//
//  GameDriver.swift
//  TCABlackJack
//
//  Created by 松本幸太郎 on 2023/06/25.
//

import SwiftyBlackjack


struct Game{
    private var blackJack:Blackjack

    //MARK: output interface
    public var dealer: Blackjack.Dealer{ blackJack.dealer }
    public var players: [Blackjack.Player]{ blackJack.players }
    public private(set) var gameState: GameState
    public private(set) var message:Message?

    init(numberOfPlayers:Int = 1) {
        self.blackJack = Blackjack(numberOfPlayers: numberOfPlayers)
        gameState = .beforeStart
    }
}

//MARK: GameState/PlayState

extension Game{
    enum GameState: CustomStringConvertible{
        case beforeStart
        case playing(PlayState)
        case over( [(name: String ,result: Blackjack.GameResult)] )

        var description: String{
            switch self{
            case .beforeStart:
                return "before start"
            case .playing(let playState):
                return "playing: playState: \(playState.description)"
            case .over(let nameAndResults):
                return "over \(nameAndResults.map{ $0.name + " " + $0.result.rawValue })"
            }
        }
    }
    
    enum PlayState:CustomStringConvertible{
        case dealingCardToPlayer(ofIndex:Int)
        case dealingCardToDealer
        case flippingDealersSecondCard
        case waitingForActionFromPlayer(ofIndex:Int)

        var description: String{
            switch self {
            case .dealingCardToPlayer:
                return "draw Card to Player"
            case .dealingCardToDealer:
                return "draw Card to Dealer"
            case .waitingForActionFromPlayer(ofIndex: let index):
                return "waiting for Action from Player \(index)"
            case .flippingDealersSecondCard:
                return "flipping Dealers Card"
            }
        }
    }

}

//MARK: input interface

extension Game{
    public mutating func startToPlay(){
        //MARK: deal player first card
        dealEachPlayerCard(checkIfBust: false)

        //MARK: deal dealer first card
        blackJack.dealCardToDealer()

        //MARK: deal player second card then check if they are bust
        dealEachPlayerCard(checkIfBust: true)

        //MARK: deal dealer second card face down. No possibility for dealer to bust.
        blackJack.dealCardToDealer(isFaceUp: false)

        //MARK: players turn
        self.gameState = .playing( .waitingForActionFromPlayer(ofIndex: 0) )
    }

    public mutating func waitForNextParticipantAction(){
        guard case .playing( .waitingForActionFromPlayer(let index) ) = self.gameState else { preconditionFailure("currentState is not waitingForActionFromPlayer") }
        let nextPlayerIndex = index + 1
        if nextPlayerIndex < blackJack.players.count{
            self.gameState = .playing( .waitingForActionFromPlayer(ofIndex: nextPlayerIndex) )
        }else{
            dealersTurn()
        }
    }

    public mutating func hit(){
        print("currentState: \(gameState)")
        guard case .playing( .waitingForActionFromPlayer(let index) ) = self.gameState else {
            preconditionFailure("currentState is not waitingForActionFromPlayer") }
        print("Game: hit() called 1. index: \(index)")

        blackJack.dealCard(toPlayerIndexOf: index)
        if blackJack.players[index].isBust{
            self.message = Message(title: "Bust", detail: "player \(index) is bust")
        }
    }

    public mutating func stand(){
        guard case .playing( .waitingForActionFromPlayer(_) ) = self.gameState else { preconditionFailure("playState is not waitingForActionFromPlayer") }
        waitForNextParticipantAction()
    }

    public mutating func resetMessage(){ self.message = nil }

}

//MARK: input internal processing

extension Game{
    private mutating func dealCard(toPlayerIndexOf index: Int){
        gameState = .playing( .dealingCardToPlayer(ofIndex: index) )
        blackJack.dealCard(toPlayerIndexOf: index)
    }
    private mutating func dealCardToDealer(isFaceUp: Bool = true){
        gameState = .playing(.dealingCardToDealer)
        blackJack.dealCardToDealer(isFaceUp: isFaceUp)
    }
    private mutating func flipDealersSecondCard(){
        gameState = .playing(.flippingDealersSecondCard)
        blackJack.flipDealersSecondCard()
    }
    private mutating func dealEachPlayerCard(checkIfBust:Bool){
        for index in 0..<blackJack.players.count {
            blackJack.dealCard(toPlayerIndexOf: index)
            if checkIfBust{
                if blackJack.players[index].isBust{
                    self.message = Message(title: "Bust", detail: "player \(index) is bust")
                }
            }
        }
    }
    private mutating func dealersTurn(){
        let validPlayers = players.filter{ !$0.isBust }
        guard validPlayers.count > 0 else{
            self.conclude()
            return
        }
        blackJack.flipDealersSecondCard()
        while blackJack.dealer.needsToDrawToItself{
            blackJack.dealCardToDealer()
            if blackJack.dealer.isBust{
                self.message = Message(title: "Bust", detail: "dealer is bust")
                self.conclude()
                return
            }
        }
        self.conclude()
    }
    private mutating func conclude(){
        let results:[(name: String, result: Blackjack.GameResult)] =
        players.map{ ( $0.name, $0.getResult(ofGameWith: dealer) ) }
        gameState = .over(results)
    }
}
