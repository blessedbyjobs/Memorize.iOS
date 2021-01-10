//
//  SettingsContentView.swift
//  memorize
//
//  Created by Artem Japparov on 06.01.2021.
//

import SwiftUI

struct SettingsContentView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var gameTheme: GameTheme
    
    @State var rubashkaColor: ColorTheme = ColorTheme.white
    
    var body: some View {
        NavigationView {
            Form {
                Picker("Rubashka Color", selection: $rubashkaColor, content: {
                    ForEach(gameTheme.rubashkaColor.colors, id: \.self) { color in
                            Text(color.name)
                                .tag(color.name)
                        }
                    })
        }
            .navigationBarTitle("Settings")
                       .navigationBarItems(trailing: Button(action: {
                           self.gameTheme.rubashkaColor.currentColor = self.rubashkaColor
                           self.presentationMode.wrappedValue.dismiss()
                       }, label: {
                           Text("Dismiss")
                       }))
        }
        .onAppear(perform: {
            self.rubashkaColor = self.gameTheme.rubashkaColor.currentColor
        })
    }
}




struct SettingsContentView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsContentView(gameTheme: GameTheme.defaultTheme())
            .preferredColorScheme(.dark)
    }
}
