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
                }
            }
            .navigationTitle("Les totos")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
