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
    @State var rule = EmojiGameRules.twoCardGameRule
    @ObservedObject var gameTheme: GameTheme = GameTheme.defaultTheme()
    
    var body: some View {
        NavigationView {
            ZStack {
                gameTheme.gameTheme.getTheme().background.color.edgesIgnoringSafeArea(.all)
                VStack(spacing: 0) {
                    topBar.padding(8)
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
//                .navigationBarItems(trailing: themeButton)
                .sheet(isPresented: $showSettings, content: { SettingsContentView(gameTheme: self.gameTheme) })
                .navigationBarHidden(true)
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
                .resizable()
                .frame(width: 20.0, height: 20.0)
                .foregroundColor(gameTheme.rubashkaColor)
        })

    }
    
    var settingsButton: some View {
        NavigationLink(destination: modePicker) {
            Image(systemName: "gearshape")
                .resizable()
                .frame(width: 20.0, height: 20.0)
                .foregroundColor(gameTheme.rubashkaColor)
        }
    }
    
    var shuffleButton: some View {
        Button(action: {
            viewModel.shuffle()
        }, label: {
            Image(systemName: "shuffle")
                .resizable()
                .frame(width: 20.0, height: 20.0)
                .foregroundColor(gameTheme.rubashkaColor)
                .padding(.leading, 16)
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
            shuffleButton
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
            ForEach(GameThemes.allCases, id: \.self) { selectedThemeWrapper in
                let selectedTheme = selectedThemeWrapper.getTheme()
                let cardContent: String? = selectedTheme.emojiTheme.content.first?.toString()
                
                Text("\(cardContent.nonNull) \(selectedTheme.name)")
                    .foregroundColor(selectedTheme.rubashkaColor)
                    .tag(selectedTheme.name)
            }
        }).pickerStyle(InlinePickerStyle())
    }
    
    var modePicker: some View {
        Picker("Mode", selection: $rule){
            ForEach(EmojiGameRules.allRules, id: \.self) { selectedRules in
                let title = "\(selectedRules.requiredCardsCount) cards"
                Text(title)
            }
        }
        .onDisappear {
            self.viewModel.updateRules(rule: rule)

        }
//        .onReceive([self.rule].publisher.first()) { (item) in
//            self.viewModel.updateRules(rule: item)
//        }
        .pickerStyle(InlinePickerStyle())
       
    }
}

struct CardView: View {
    
    var isMatched: Bool = false
    var lable: String
    var isFaceUp: Bool? = nil
    var card: Card<String>
    @ObservedObject var gameTheme: GameTheme
    
    init(card: Card<String>, gameTheme: GameTheme) {
        self.lable = gameTheme.gameTheme.getTheme().emojiTheme.content.at(Int(card.content) ?? 0)
        self.isMatched = card.isMatched
        self.gameTheme = gameTheme
        self.card = card
        self.isFaceUp = card.isFaceUp
    }
    
    var body: some View {
        ZStack {
            if isFaceUp == true {
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                    .fill(Color.white)
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                    .stroke(lineWidth: 3.0)
                    .foregroundColor(gameTheme.rubashkaColor)
                Pie(
                    startAngle: Angle.degrees(gameTheme.pieStartAngle),
                    endAngle: Angle.degrees(gameTheme.pieEndAngle),
                    clockwise: true
                )
                .fill(gameTheme.rubashkaColor)
                .padding(5)
                .opacity(gameTheme.pieOpacity)
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
