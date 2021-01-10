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
                viewModel.gameTheme.background.currentColor.color.edgesIgnoringSafeArea(.all)
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
                .background(viewModel.gameTheme.background.currentColor.color)
                .navigationBarItems(trailing: settingsButton)
                .sheet(isPresented: $showSettings, onDismiss: {
                    self.gameTheme.rubashkaColor = self.viewModel.gameTheme.rubashkaColor
                }, content: {
                    SettingsContentView(gameTheme: self.gameTheme)
                })
            }
        }
        .onAppear(perform: {
            gameTheme.rubashkaColor = self.viewModel.gameTheme.rubashkaColor
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
