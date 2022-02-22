//
//  IntentListAllergen.swift
//  fiche-technique-cuisine (iOS)
//
//  Created by etud on 22/02/2022.
//

import Foundation
import Combine

enum IntentStateListAllergen: CustomStringConvertible, Equatable {
    case ready
    case nameChanging(String)
    case nameChanged(String)
    case nameChangingError(String)
    
    var description: String {
        switch self {
        case .ready: return "state .ready"
        case .nameChanging(let name): return "nameChanging \(name)"
        case .nameChanged(let name): return "name changed \(name)"
        case .nameChangingError(let err): return "name error: \(err)"
        }
    }
}

class IntentListAllergen {
    
    private var state = PassthroughSubject<IntentStateListAllergen, Never>()
    
    private var allergen_model: [Allergen]
    
    init (model: [Allergen]) {
        self.allergen_model = model
    }
}
