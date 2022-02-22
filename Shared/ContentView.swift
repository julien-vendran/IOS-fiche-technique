//
//  ContentView.swift
//  Shared
//
//  Created by m1 on 10/02/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            Form {
                Section {
                    NavigationLink(destination: listIngredient()) {
                        Text("Liste des ingrédients")
                    }.navigationTitle("")
                    NavigationLink(destination: listAllergen()) {
                        Text("Liste des allergènes")
                    }.navigationTitle("")
                }
            }
            .navigationTitle("Les totos")
        }.navigationViewStyle(StackNavigationViewStyle()) //Corrige les erreurs console du demarage
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
