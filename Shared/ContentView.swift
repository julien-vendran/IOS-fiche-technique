//
//  ContentView.swift
//  Shared
//
//  Created by m1 on 10/02/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
       Group{
        
        TabView {
            listIngredient()
                .tabItem {
                    Label(" 🥕 Ingrédients", systemImage: "list.dash")
                }
            listAllergen()
                .tabItem {
                    Label("Allergènes", systemImage: "square.and.pencil")
                }
            ListRecipe()
                .tabItem {
                    Label("Recettes", systemImage: "pencil.slash")
                }
        }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
