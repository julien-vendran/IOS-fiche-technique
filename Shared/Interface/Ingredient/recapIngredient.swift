//
//  recapIngredient.swift
//  fiche-technique-cuisine (iOS)
//
//  Created by m1 on 06/03/2022.
//

import SwiftUI

struct RecapIngredient: View {
    
    private var recapIngredients = [String:Double]()
    private var recapUnit = [String:String]()
    
    init (recipe: Recipe) {
        self.searchInRecipe(recipe: recipe)
    }
    
    mutating func searchInRecipe (recipe: Recipe) {
        for step: RecipeOrStep in recipe.listOfStep {
            if (step is Step) {
                for d: Denree in (step as! Step).denreeUsed {
                    if let ingredient: Ingredient = d.ingredient {
                        var qte_initial: Double = 0.0
                        if let recap_val = self.recapIngredients[ingredient.name] { //Lingrédient est déjà enregistré
                            qte_initial = recap_val
                        } else {
                            self.recapUnit.updateValue(ingredient.unit, forKey: ingredient.name)
                        }
                        self.recapIngredients.updateValue(qte_initial + d.quantity, forKey: ingredient.name)
                    }
                }
            } else {
                searchInRecipe(recipe: (step as! Recipe))
            }
        }
    }
    
    var body: some View {
        List {
            ForEach(self.recapIngredients.sorted(by: >), id: \.key) { (key, value) in
                let formatted = String(format: "%.1f", value)
                Text("\(key) - \(formatted) \(self.recapUnit[key]!)")
            }
        }
    }
}
