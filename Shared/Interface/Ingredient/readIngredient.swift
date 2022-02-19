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
            Text("Nom :"); Text("\(ingredient.name)")
            Text("Unité :"); Text("\(ingredient.unit)")
            Text("Quantité disponible"); Text("\(ingredient.availableQuantity)")
            Text("Prix unitaire"); Text("\(ingredient.unitPrice)")
        }
        .navigationTitle("\(ingredient.name)")
        .task {
                var urlData: URL? = URL(string: "https://api.unsplash.com/search/photos?page=1&query=\(ingredient.name)&per_page=1&client_id=p-ZL92yXYzvXKuf5exoqtIbhxEkI3iJEPFY_uucK8VI&fbclid=IwAR1KgNTMdFmu-WoNAq3rZvdH-bko9xG-BSAnsBAQNCVj9-WkXfCQ6cEOJpc")
               if let url = urlData{
                    do{
                   
                    let decoded : imgDTO = try await URLSession.shared.getJSON(from: url)
                        if let resulturl = decoded.results[0].urls{
                            self.url = resulturl.thumb
                        }else{
                            print("Impossible de recup img")
                        }
                   // self.url=decoded.results[0].urls.thumb //TODO check si il y a un resultat
                    }catch let error {
                            print(error.localizedDescription)
                    }
                }
           
             
        }
       
    }
}

/*struct readIngredient_Previews: PreviewProvider {
    static var previews: some View {
        ReadIngredient(ingredient: Ingredient(name: "Patate", unit: "kg", availableQuantity: 20, unitPrice: 2, associatedAllergen: [], denreeUsed: Denree(), id: nil))
    }
}*/
