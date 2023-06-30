//
//  GamePresenter.swift
//  TCABlackJack
//
//  Created by 松本幸太郎 on 2023/06/23.
//

import SwiftyBlackjack

struct GamePresenter{
    public private(set) var game: Game = Game()
}

// MARK: Output

extension GamePresenter{
    public var playerCount:Int{ game.players.count }
    public var playerTurnIndex:Int?{
        guard case .playing(.waitingForActionFromPlayer(let index)) =
                game.gameState else{ return nil }
        return index
    }
    public var alert:Message?{ game.message }
    public var addPlayerIsEnabled:Bool{
        guard case .beforeStart =
                game.gameState else{ return false }
        return true
    }
    public var removePlayerIsEnabled:Bool{
        guard case .beforeStart =
                game.gameState else{ return false }
        return true
    }
    public var hitButtonIsEnabled:Bool{
        guard case .playing(.waitingForActionFromPlayer(_)) =
                game.gameState else{ return false }
        return true
    }

    public var standButtonIsEnabled:Bool{
        guard case .playing(.waitingForActionFromPlayer(_)) =
                game.gameState else{ return false }
        return true
    }
    public var startButtonIsEnabled:Bool{
        guard case .beforeStart =
                game.gameState else{ return false }
        return true
    }
    public var resetButtonIsEnabled:Bool{
        guard case .beforeStart =
                game.gameState else{ return true }
        return false
    }

}

// MARK: Input

extension GamePresenter{
    public mutating func addPlayer(){
        if playerCount + 1 <= 7 { //7 players at maximum
            self.game = Game(numberOfPlayers: playerCount + 1)
        }
    }

    public mutating func removePlayer(){
        if playerCount - 1 >= 1 { //1 player at least
           self.game = Game(numberOfPlayers: playerCount - 1)
        }
    }

    public mutating func startToPlay(){ game.startToPlay() }
    public mutating func hit(){ game.hit() }
    public mutating func stand(){ game.stand() }
    public mutating func reset(){ self = .init() }
    public mutating func onAlertDismissed(){
        game.resetMessage()
        if case .playing( .waitingForActionFromPlayer(_) ) = game.gameState{
            game.waitForNextParticipantAction()
        }
    }
}

