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
    @State var list : Set<Allergen>
    init() {
        self.allergens = []
        self.list = Set()
    }
    var body: some View {
        VStack {
            Text("Allergènes")
                .font(.largeTitle)
            List(selection: $list) {
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
            .sheet(isPresented: $showingAddSheet) {
                createAllergen()
            }
            HStack {
                EditButton()
                Button("Ajouter") {
                    self.showingAddSheet.toggle()
                }
            }.frame(height: 40)
        }
        .task {
        
            let url = URL(string: "https://fiche-technique-cuisine-back.herokuapp.com/allergen")
            do {
                //Ici on récupere une liste de IngredientDTO (il comprends que le json est un tableau de IngredietnsDTO tout seul) !
                let decoded : [AllergenDTO] = try await URLSession.shared.getJSON(from: url!)
            
                //Pour chaque element dto on converti, compactMap =map mais plus simple
                let maliste : [Allergen] = decoded.compactMap{ (dto: AllergenDTO) -> Allergen in
                    return dto.allergen
                }
                self.allergens = maliste
            }  catch let error {
                print(error.localizedDescription)
            }
        }
    }
}
