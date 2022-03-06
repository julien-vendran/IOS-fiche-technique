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
        NavigationView() {
            VStack {
                Spacer()
                List {
                    ForEach((0..<self.recipeListVM.count), id: \.self) { idRecipe in
                        VStack {
                            NavigationLink(destination: ReadRecipe(recipe: self.recipeListVM[idRecipe])) {
                                Text("\(self.recipeListVM[idRecipe].name)")
                            }
                            .navigationTitle("Vos recettes ")
                        }
                    }
                    .onDelete() { indexSet in
                        let recipes_to_del = self.recipeListVM.removeRecipes(atOffsets: indexSet)
                        Task{
                            for recipe in recipes_to_del {
                                await self.recipeIntent.intentToDelete(recipe: recipe)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Vos recettes")
            .task {
                if (self.recipeListVM.isEmpty) {
                    await self.recipeIntent.intentToLoad()
                }
            }
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    EditButton()
                }
                ToolbarItem(placement: .primaryAction) {
                    NavigationLink (destination: createRecipe(recipeIntent: self.recipeIntent, recipeInStock: self.recipeListVM.associated_recipe_list)) {    
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}

struct ListRecipe_Previews: PreviewProvider {
    static var previews: some View {
        ListRecipe()
    }
}

