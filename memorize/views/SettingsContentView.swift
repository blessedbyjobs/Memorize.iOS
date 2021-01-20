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
    
    @State var theme = GameThemes.HALLOWEEN
    
    var body: some View {
        NavigationView {
            Form {
                Picker("Theme", selection: $theme, content: {
                    ForEach(GameThemes.allCases, id: \.self) { selectedThemeName in
                        let selectedTheme = selectedThemeName.getTheme()
                        Text(selectedTheme.name)
                            .tag(selectedTheme.name)
                    }
                }).pickerStyle(WheelPickerStyle())
            }
            .navigationBarTitle("Settings")
            .navigationBarItems(trailing: Button(action: {
                self.gameTheme.gameTheme = self.theme
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Dismiss")
            }))
        }
        .onAppear(perform: {
            //            self.rubashkaColor = self.gameTheme.rubashkaColor.currentColor
            //            self.backgroundColor = self.gameTheme.background.currentColor
            
        })
    }
}





struct SettingsContentView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsContentView(gameTheme: GameTheme.defaultTheme())
            .preferredColorScheme(.dark)
    }
}
