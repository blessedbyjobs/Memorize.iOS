//
//  ContentView.swift
//  memorize
//
//  Created by Artem Japparov on 28.12.2020.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: EmojiMemoryGame = EmojiMemoryGame()
    
    var body: some View {
        Grid(viewModel.cards) { card in
            CardView(lable: card.content)
        }
        
    }
}

struct CardView: View {
    
    var isFaceUp: Bool = true
    var lable: String
    
    init(lable: String) {
        self.lable = lable
    }
    
    var body: some View {
        ZStack {
            if isFaceUp {
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/).fill(Color.white)
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/).stroke(lineWidth: 3.0)
                Text(lable)
                    .font(.largeTitle)
            } else {
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/).fill()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
