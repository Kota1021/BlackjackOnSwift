//
//  FlipView.swift
//  TCABlackJack
//
//  Created by 松本幸太郎 on 2023/06/29.
//
// Refer to: https://github.com/jrasmusson/swiftui/blob/main/Animations/CardFlip

import SwiftUI

struct FlipView<FrontContent,BackContent>: View  where FrontContent: View, BackContent: View{
    let width: CGFloat
    let height: CGFloat
    let durationAndDelay: CGFloat = 0.3

    let backView: BackContent
    let frontView: FrontContent

    init(_ frontIsUp:Binding<Bool>,
         width : CGFloat = 50,
         height : CGFloat = 75,
         front frontView: FrontContent,
         back backView: BackContent) {
        
        self._frontIsUp = frontIsUp
        if frontIsUp.wrappedValue{
            self._backDegree = State(wrappedValue: CGFloat(90) )
            self._frontDegree = State(wrappedValue: CGFloat(0) )
        }else{
            self._backDegree = State(wrappedValue: CGFloat(0) )
            self._frontDegree = State(wrappedValue: CGFloat(90) )
        }

        self.width = width
        self.height = height

        self.backView = backView
        self.frontView = frontView
    }

    //MARK: Variables
    @Binding var frontIsUp:Bool
    @State var backDegree:CGFloat
    @State var frontDegree:CGFloat

    //MARK: View Body
    var body: some View {
        ZStack {
            backView
                .rotation3DEffect(Angle(degrees: backDegree), axis: (x: 0, y: 1, z: 0))

            frontView
                .frame(width: width, height: height)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(.gray)
                )
                .rotation3DEffect(Angle(degrees: frontDegree), axis: (x: 0, y: 1, z: 0))
        }
        .onChange(of: frontIsUp) { newValue in
            if newValue {
                withAnimation(.linear(duration: durationAndDelay)) {
                    backDegree = 90
                }
                withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
                    frontDegree = 0
                }
            }else{
                withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
                    backDegree += 90
                }
                withAnimation(.linear(duration: durationAndDelay)) {
                    frontDegree += 90
                }

            }
        }
    }
}

struct FlipView_Previews: PreviewProvider {
    static var previews: some View {
        FlipView(.constant(true), front: Text("front"), back: Text("back"))
    }
}
