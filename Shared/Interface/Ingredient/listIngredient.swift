//
//  listIngredient.swift
//  fiche-technique-cuisine (iOS)
//
//  Created by m1 on 16/02/2022.
//

import SwiftUI

struct listIngredient: View {
    @State var ingredients : [Ingredient]
    @State var showingCreateSheet	: Bool = false
    @State var currentIngredient : Ingredient? = nil
    
    init() {
        self.ingredients=[]
    }
    var body: some View {
       // NavigationView {
            VStack {
                HStack{
                    Button(action:{ showingCreateSheet.toggle()}){
                        Image(systemName: "plus")
                    }
                    
                }.sheet(isPresented: $showingCreateSheet){
                    createIngredient(showingSheet: $showingCreateSheet)
                }
                List {
                    ForEach(0..<ingredients.count, id: \.self) { index in
                        Group {
                            Button("\(self.ingredients[index].name)") {
                                self.currentIngredient = self.ingredients[index]
                                    }
                        }
                        /*NavigationLink(destination: ReadIngredient(ingredient: self.ingredients[index])) {
                            Text(self.ingredients[index].name)
                        }.navigationTitle("Liste ingrédients")*/
                    }
                    .onDelete{indexSet in
                        ingredients.remove(atOffsets: indexSet)
                    }
                    .onMove{ indexSet, index in
                        ingredients.move(fromOffsets: indexSet, toOffset: index)
                    }
                    
                }.sheet(item: $currentIngredient) { ing in
                    ReadIngredient(ingredient: ing)
                }
                EditButton()
            }
    /*}.navigationBarItems(
            trailing: Button(action:{ showingCreateSheet.toggle()}){
                Image(systemName: "plus")
            }.sheet(isPresented: $showingCreateSheet){
                createIngredient()
            }
        )*/
        .task {
            
            do {
                
                //Ici on récupere une liste de IngredientDTO (il comprends que le json est un tableau de IngredietnsDTO tout seul) !
                let decoded : [IngredientDTO] = try await IngredientService.getAllIngredient()
            //Pour chaque element dto on converti, compactMap =map mais plus simple
                let maliste : [Ingredient] = decoded.compactMap{ (dto: IngredientDTO) -> Ingredient in
                    return dto.ingredient
                }
                self.ingredients = maliste
                
            } catch let error {
                    print(error.localizedDescription)
                
            }
        }
       
            
    }
}

struct listIngredient_Previews: PreviewProvider {
    static var previews: some View {
        listIngredient()
    }
}
