//
//  readIngredient.swift
//  fiche-technique-cuisine (iOS)
//
//  Created by m1 on 17/02/2022.
//

import SwiftUI

struct ReadIngredient: View {
    @ObservedObject var vm : IngredientCreateVM
    var intent : IntentIngredientCreate
    
    @State var ingredient: Ingredient
    @State var url: String
    
    init (ingredient : Ingredient) {
        self.ingredient = ingredient
        self.url = "https://www.cjoint.com/doc/20_12/JLFrj6Sanqu_image-not-found.png"
        
        self.vm = IngredientCreateVM()
        self.intent = IntentIngredientCreate()
        self.intent.addObserver(viewModel: self.vm)
    }
    
    let col = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: self.url)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image.resizable()
                         .aspectRatio(contentMode: .fit)
                         .frame(maxWidth: 300, maxHeight: 100)
                case .failure:
                    Image(systemName: "photo")
                @unknown default:
                    EmptyView()
                }
            }
            .navigationTitle("\(self.ingredient.name)")
            CreateIngredient(ingredient_to_update: self.ingredient)
        }
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
