//
//  recipe-or-step.swift
//  fiche-technique-cuisine (iOS)
//
//  Created by m1 on 15/02/2022.
//

import Foundation

class RecipeOrStep {
    var id: Int?
    var name: String
    
    init (name: String, id: Int?) {
        self.id = id
        self.name = name
    }
}
