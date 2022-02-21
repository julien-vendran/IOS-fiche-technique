//
//  readIngredient.swift
//  fiche-technique-cuisine (iOS)
//
//  Created by m1 on 17/02/2022.
//

import SwiftUI

struct ReadIngredient: View {
    @State var ingredient: Ingredient
    @State var url: String
    init (ingredient : Ingredient) {
        self.ingredient = ingredient
        self.url = "https://www.cjoint.com/doc/20_12/JLFrj6Sanqu_image-not-found.png"
       
    }
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: self.url))
            Spacer().frame(height: 30)
            
            HStack {
                VStack(alignment: .leading) {
                    Group {
                        Text("Nom :")
                        Text("Unité :")
                        Text("Quantité disponible :")
                        Text("Prix unitaire :")
                    }.padding(1)
                }
                VStack(alignment: .leading) {
                    Group {
                        Text("\(ingredient.name)")
                        Text("\(ingredient.unit)")
                        Text("\(ingredient.availableQuantity)")
                        Text("\(ingredient.unitPrice)")
                    }.padding(1)
                }
            }
            
            Spacer().frame(width: .infinity, height: 30)
        }
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity
          )
        .navigationTitle("\(ingredient.name)")
        .task {
            let urlData: URL? = URL(string: "https://api.unsplash.com/search/photos?page=1&query=\(ingredient.name)&per_page=1&client_id=p-ZL92yXYzvXKuf5exoqtIbhxEkI3iJEPFY_uucK8VI&fbclid=IwAR1KgNTMdFmu-WoNAq3rZvdH-bko9xG-BSAnsBAQNCVj9-WkXfCQ6cEOJpc")
            if let url: URL = urlData {
                    do {
                   
                    let decoded : imgDTO = try await URLSession.shared.getJSON(from: url)
                        if decoded.results.count > 0 {
                            if let resulturl = decoded.results[0].urls{
                                self.url = resulturl.thumb
                            } else {
                                print("Impossible de recup img")
                            }
                        } else {
                            print("Erreur dans le résultat")
                        }
                   // self.url=decoded.results[0].urls.thumb //TODO check si il y a un resultat
                    } catch let error {
                            print(error.localizedDescription)
                    }
                }
        }
    }
}

struct readIngredient_Previews: PreviewProvider {
    static var previews: some View {
        ReadIngredient(ingredient: Ingredient(name: "Patate", unit: "kg", availableQuantity: 20, unitPrice: 2, associatedAllergen: [], denreeUsed: [], id: nil))
    }
}
