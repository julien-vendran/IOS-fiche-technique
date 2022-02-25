//
//  step.swift
//  fiche-technique-cuisine (iOS)
//
//  Created by m1 on 15/02/2022.
//

import Foundation

class Step: RecipeOrStep {
    var description: String
    var duration: Double
    var denreeUsed: [Denree]
    
    init (
        name: String,
        description: String,
        duration: Double,
        denreeUsed: [Denree],
        id: Int?
    ) {
        self.description = description
        self.duration = duration
        self.denreeUsed = denreeUsed
        super.init(name: name, id: id)
    }
}
