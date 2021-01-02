//
//  ContentView.swift
//  memorize
//
//  Created by Artem Japparov on 28.12.2020.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: EmojiMemoryGame = EmojiMemoryGame(gameTheme: GameTheme.defaultTheme())
    
    var body: some View {
        Grid(viewModel.cards) { card in
            CardView(
                card: card,
                fillingColor: viewModel.gameTheme.rubashkaColor.currentColor
            ).onTapGesture {
                viewModel.chooseCard(card: card)
            }
        }.background(viewModel.gameTheme.background.currentColor)
        
    }
}

struct CardView: View {
    
    var isFaceUp: Bool = true
    var isMatched: Bool = false
    var lable: String
    let fillingColor: Color
    
    init(card: MemoryGame<String>.Card, fillingColor: Color) {
        self.lable = card.content
        self.isFaceUp = card.isFaceUp
        self.isMatched = card.isMatched
        self.fillingColor = fillingColor
    }
    
    var body: some View {
        ZStack {
            if !isMatched {
                if isFaceUp {
                    RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/).fill(Color.white)
                    RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/).stroke(lineWidth: 3.0)
                        .foregroundColor(fillingColor)
                    Text(lable)
                        .font(.largeTitle)
                        .foregroundColor(fillingColor)
                } else {
                    RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/).fill(fillingColor)
                }
            } else {
                Rectangle().fill(Color.gray)
            }
        }
        .padding()
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
