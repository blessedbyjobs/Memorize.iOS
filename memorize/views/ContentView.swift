//
//  ContentView.swift
//  memorize
//
//  Created by Artem Japparov on 28.12.2020.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: EmojiMemoryGame = EmojiMemoryGame(gameTheme: GameTheme.defaultTheme())
    
    @State var showSettings: Bool = false
    @ObservedObject var gameTheme: GameTheme = GameTheme.defaultTheme()
    
    var body: some View {
        NavigationView {
            ZStack {
                viewModel.gameTheme.gameTheme.getTheme().background.color.edgesIgnoringSafeArea(.all)
                VStack(spacing: 0) {
                    Grid(viewModel.cards) { card in
                        CardView(
                            card: card,
                            gameTheme: gameTheme
                        ).onTapGesture {
                            viewModel.chooseCard(card: card)
                        }
                    }
                    .padding(.top, 0)
                    HStack {
                        Text("Score: \(viewModel.score)")
                            .fontWeight(.semibold)
                            .padding(.vertical, 8)
                            .foregroundColor(gameTheme.rubashkaColor)
                        Spacer()
                    }.padding(.horizontal, 8)
                }
                .padding(.horizontal, 8)
                .background(viewModel.gameTheme.gameTheme.getTheme().background.color)
                .navigationBarItems(trailing: settingsButton)
                .sheet(isPresented: $showSettings, onDismiss: {
                        self.gameTheme.gameTheme = self.viewModel.gameTheme.gameTheme
                }, content: {
                    SettingsContentView(gameTheme: self.viewModel.gameTheme)
                })
            }
        }
        .onAppear(perform: {
            self.gameTheme.gameTheme = self.viewModel.gameTheme.gameTheme
        })
    }
    
    var newGameButton: some View {
        Button(action: {
            viewModel.newGame()
        }, label: {
            Image(systemName: "plus")
                .foregroundColor(gameTheme.rubashkaColor)
        })

    }
    
    var settingsButton: some View {
        Button(action: {
            self.showSettings = true
        }, label: {
            Image(systemName: "gearshape")
                .foregroundColor(gameTheme.rubashkaColor)
        })
    }
}

struct CardView: View {
    
    var isFaceUp: Bool = true
    var isMatched: Bool = false
    var lable: String
    @ObservedObject var gameTheme: GameTheme
    
    
    init(card: Card<String>, gameTheme: GameTheme) {
        self.lable = gameTheme.gameTheme.getTheme().emojiTheme.content.at(Int(card.content) ?? 0)

        self.isFaceUp = card.isFaceUp
        self.isMatched = card.isMatched
        self.gameTheme = gameTheme
    }
    
    var body: some View {
        ZStack {
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
        }
        .padding(8.0)
        .opacity(isMatched ? 0 : 1)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
