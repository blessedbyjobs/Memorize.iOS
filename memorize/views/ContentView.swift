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
        VStack(spacing: 0) {
            HStack {
                Image(systemName: "plus")
                    .padding(8)
                Spacer()
                Image(systemName: "gearshape")
                    .padding(8)
            }
            .foregroundColor(viewModel.gameTheme.rubashkaColor)
            .padding(.top, 8)
            .padding(.bottom, 0)
            Grid(viewModel.cards) { card in
                CardView(
                    card: card,
                    gameTheme: viewModel.gameTheme
                ).onTapGesture {
                    viewModel.chooseCard(card: card)
                }
            }
            .padding(.top, 0)
            HStack {
                Text("Score: \(viewModel.score)")
                    .fontWeight(.semibold)
                    .padding(.vertical, 8)
                    .foregroundColor(viewModel.gameTheme.rubashkaColor)
                Spacer()
            }.padding(.horizontal, 8)
        }
        .padding(.horizontal, 8)

        .background(viewModel.gameTheme.background.currentColor)
    }
}

struct CardView: View {
    
    var isFaceUp: Bool = true
    var isMatched: Bool = false
    var lable: String
    let gameTheme: GameTheme
    
    init(card: Card<String>, gameTheme: GameTheme) {
        self.lable = card.content
        self.isFaceUp = card.isFaceUp
        self.isMatched = card.isMatched
        self.gameTheme = gameTheme
    }
    
    var body: some View {
        ZStack {
            if !isMatched {
                if isFaceUp {
                    RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                        .fill(Color.white)
                    RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                        .stroke(lineWidth: 3.0)
                        .foregroundColor(gameTheme.rubashkaColor)
                    Text(lable)
                        .font(.largeTitle)
                        .foregroundColor(gameTheme.rubashkaColor)
                } else {
                    RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                        .fill(gameTheme.rubashkaColor)
                }
            } else {
                Rectangle().fill(gameTheme.background)
            }
        }
        .padding(8.0)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
