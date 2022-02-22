//
//  SwiftUIView.swift
//  fiche-technique-cuisine (iOS)
//
//  Created by m1 on 15/02/2022.
//
		
import SwiftUI

struct ListRecipe: View {
    @ObservedObject var recipeListVM: RecipeListeVM
    var recipeIntent: IntentRecipeList
    
    init () {
        self.recipeIntent = IntentRecipeList()
        self.recipeListVM = RecipeListeVM(recipe: [])
        self.recipeIntent.addObserver(viewModel: self.recipeListVM)
    }
    
    var body: some View {
        VStack {
            Spacer()
            Text("Liste de vos recettes ")
                .font(.largeTitle)
            List {
                ForEach(self.$recipeListVM.associated_recipe_list, id: \.id) { recipe in
                    VStack {
                        Text("Test")
                    }
                }
                .onDelete() { indexSet in
                    self.recipeListVM.associated_recipe_list.remove(atOffsets: indexSet)
                }
            }
            EditButton()
        }
        .navigationTitle("Vos recettes")
        .task {
            print("Début de la lecture de nos recettes")
            await self.recipeIntent.intentToLoad()
        }
    }
}

struct ListRecipe_Previews: PreviewProvider {
    static var previews: some View {
        ListRecipe()
    }
}
	
						
