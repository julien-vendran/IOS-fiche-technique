//
//  IntentListAllergen.swift
//  fiche-technique-cuisine (iOS)
//
//  Created by etud on 22/02/2022.
//

import Foundation
import Combine

class IntentListAllergen {
    
    private var allergen_model: [Allergen]
    
    init (model: [Allergen]) {
        self.allergen_model = model
    }
}
