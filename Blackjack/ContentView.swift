//
//  ContentView.swift
//  Blackjack
//
//  Created by 松本幸太郎 on 2023/06/30.
//

import SwiftUI
import SwiftyBlackjack

struct ContentView: View {
    @State private var gamePresenter = GamePresenter()

    var body: some View {
        VStack{
            Spacer()
            HStack{
                Text("\(gamePresenter.game.gameState.description)")
            }
            DealerHandView(of: gamePresenter.game.dealer)
            HStack{
                if gamePresenter.addPlayerIsEnabled{
                    Button("+"){
                        gamePresenter.addPlayer()
                    }.buttonStyle(.bordered)
                }
                ForEach(0..<gamePresenter.playerCount,id:\.self){ index in
                    PlayerHandView(of: gamePresenter.game.players[index], isTurn: gamePresenter.playerTurnIndex == index)
                }
                if gamePresenter.removePlayerIsEnabled{
                    Button("-"){
                        gamePresenter.removePlayer()
                    }.buttonStyle(.bordered)
                }
            }

            HStack{
                Button{
                    gamePresenter.stand()
                }label: {
                    Text("Stand")
                }.buttonStyle(.bordered)
                    .disabled(!gamePresenter.standButtonIsEnabled)
                Button{
                    gamePresenter.hit()
                }label: {
                    Text("Hit")
                }.buttonStyle(.bordered)
                    .disabled(!gamePresenter.hitButtonIsEnabled)
            }
            Spacer()
            HStack{
                Button("Reset"){ gamePresenter.reset() }
                    .disabled(!gamePresenter.resetButtonIsEnabled)
                Button("Start"){ gamePresenter.startToPlay() }
                    .disabled(!gamePresenter.startButtonIsEnabled)
            }
            Spacer()
        }
        .padding()
        .alert(gamePresenter.alert?.title ?? "nil",
               isPresented: .constant(gamePresenter.alert != nil) ) {
            Button("OK"){ gamePresenter.onAlertDismissed() }
        }message: {
            Text(gamePresenter.alert?.detail ?? "nil")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
