//
//  ContentView.swift
//  memorize
//
//  Created by Artem Japparov on 28.12.2020.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var viewModel: EmojiMemoryGame = EmojiMemoryGame()
    
    @State var showSettings: Bool = false
    @State var theme = GameThemes.HALLOWEEN
    @ObservedObject var gameTheme: GameTheme = GameTheme.defaultTheme()
    
    var body: some View {
        NavigationView {
            ZStack {
                gameTheme.gameTheme.getTheme().background.color.edgesIgnoringSafeArea(.all)
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
                    bottomBar.padding(.horizontal, 8)
                }
                .padding(.horizontal, 8)
                .background(gameTheme.gameTheme.getTheme().background.color)
                .navigationBarItems(trailing: themeButton)
                .sheet(isPresented: $showSettings, content: { SettingsContentView(gameTheme: self.gameTheme) })
            }
        }
    }
    
    var themeButton: some View {
        NavigationLink(destination: picker) {
            Text(gameTheme.gameTheme.getTheme().name)
                .fontWeight(.semibold)
                .foregroundColor(gameTheme.rubashkaColor)
            
        }
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
    
    var topBar: some View {
        HStack {
            Spacer()
            themeButton
        }
    }
    
    var bottomBar: some View {
        HStack {
            newGameButton
            Spacer()
            Text("Score: \(viewModel.score)")
                .fontWeight(.semibold)
                .padding(.vertical, 8)
                .foregroundColor(gameTheme.rubashkaColor)
            Spacer()
            settingsButton
        }
    }
    
    var picker: some View {
        Picker("Theme", selection: $gameTheme.gameTheme, content: {
            ForEach(GameThemes.allCases, id: \.self) { selectedThemeName in
                let selectedTheme = selectedThemeName.getTheme()
                let cardContent: String? = selectedTheme.emojiTheme.content.first?.toString()
                
                Text("\(cardContent.nonNull) \(selectedTheme.name)")
                    .foregroundColor(selectedTheme.rubashkaColor)
                    .tag(selectedTheme.name)
            }
        }).pickerStyle(InlinePickerStyle())
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
