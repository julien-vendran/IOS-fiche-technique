//
//  listIngredient.swift
//  fiche-technique-cuisine (iOS)
//
//  Created by m1 on 16/02/2022.
//

import SwiftUI

struct listAllergen: View {
    @State var allergens : [Allergen]
    @State var showingAddSheet: Bool = false
    
    init() {
        self.allergens = []
    }
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(0..<allergens.count, id: \.self) { index in
                        Group {
                            Text("\(self.allergens[index].name)")
                        }
                    }
                    .onDelete{indexSet in
                        allergens.remove(atOffsets: indexSet)
                    }
                    .onMove{ indexSet, index in
                        allergens.move(fromOffsets: indexSet, toOffset: index)
                    }
                }
                EditButton()
            }
        } .task {
            
            let url = URL(string: "https://fiche-technique-cuisine-back.herokuapp.com/allergen")
            do {
                //Ici on récupere une liste de IngredientDTO (il comprends que le json est un tableau de IngredietnsDTO tout seul) !
                let decoded : [AllergenDTO] = try await URLSession.shared.getJSON(from: url!)
            
                //Pour chaque element dto on converti, compactMap =map mais plus simple
                let maliste : [Allergen] = decoded.compactMap{ (dto: AllergenDTO) -> Allergen in
                    return dto.allergen
                }
                self.allergens = maliste
            } catch {
                    print("erreur ")
                
            }
        }
    }
}

/*struct listIngredient_Previews: PreviewProvider {
    static var previews: some View {
        listIngredient()
    }
}*/
