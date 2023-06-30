//
//  CardView.swift
//  TCABlackJack
//
//  Created by 松本幸太郎 on 2023/06/23.

import SwiftUI
import SwiftyBlackjack

struct CardView: View {
    private let card:Card
    private let width : CGFloat = 50
    private let height : CGFloat = 75
    init(_ card: Card) { self.card = card }

    //MARK: View Body
    var body: some View {
        FlipView(.constant(card.isFaceUp),
                 width: width,
                 height: height,
                 front: CardFace(card.face, width: width, height: height),
                 back: CardBack(width: width, height: height) )
    }
    
}

fileprivate struct CardFace : View {
    let face:Card.Face
    let width : CGFloat
    let height : CGFloat

    init(_ face: Card.Face, width: CGFloat, height: CGFloat) {
        self.face = face
        self.width = width
        self.height = height
    }
    
    var body: some View {
        VStack{
            Text(face.suit.rawValue)
            Text(face.rank.rawValue)
        }.frame(width: width, height: height)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(.gray)
            )
    }
}

fileprivate struct CardBack : View {
    let width : CGFloat
    let height : CGFloat

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .stroke(.blue.opacity(0.7), lineWidth: 3)
                .frame(width: width, height: height)
            
            RoundedRectangle(cornerRadius: 8)
                .fill(.blue.opacity(0.2))
                .frame(width: width * 0.8, height: height *  0.8)
                .shadow(color: .gray, radius: 2, x: 0, y: 0)
            
            Image(systemName: "seal.fill")
                .resizable()
                .frame(width: width * 0.6, height:  width * 0.6)
                .foregroundColor(.blue.opacity(0.7))
            
            Image(systemName: "seal")
                .resizable()
                .frame(width: width * 0.4, height: width * 0.4)
                .foregroundColor(.white)
            
            Image(systemName: "seal")
                .resizable()
                .frame(width: width * 0.3, height: width * 0.3)
                .foregroundColor(.blue.opacity(0.7))
            
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(PreviewData.card0)
    }
}
