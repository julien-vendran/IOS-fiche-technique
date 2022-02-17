//
//  recipe.swift
//  fiche-technique-cuisine (iOS)
//
//  Created by m1 on 15/02/2022.
//

import Foundation
/*
 {"parents":{"parents":null,"id":11,"name":"Purée steack","responsable":"Cuisinier ","nbOfCover":4,"category":"Plat pour enfant"},"id":9,"name":"Purée de pomme de terre","responsable":"Cuisinier","nbOfCover":4,"category":"Plat","listOfSteps":
 */
class Recipe: RecipeOrStep {
    var responsable: String
    var nbOfCover: Int
    var category: String
    var listOfStep: [RecipeOrStep]
    
    init (
        name: String,
        responsable: String,
        nbOfCover: Int,
        category: String,
        listOfStep: [RecipeOrStep],
        id: Int? = nil
    ) {
        self.responsable = responsable
        self.nbOfCover = nbOfCover
        self.category = category
        self.listOfStep = listOfStep
        super.init(name: name, id: id)
    }
    
}

