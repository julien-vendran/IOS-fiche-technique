//
//  recipe.swift
//  fiche-technique-cuisine (iOS)
//
//  Created by m1 on 15/02/2022.
//

import Foundation

class Recipe: RecipeOrStep, ObservableObject {
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
    
    override func getSteps() -> [Step] {
        var steps : [Step] = []
        for r in listOfStep{
            steps += r.getSteps()
        }
        return steps
    }
    
}

