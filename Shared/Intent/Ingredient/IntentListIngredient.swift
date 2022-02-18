//
//  IntentListIngredient.swift
//  fiche-technique-cuisine (iOS)
//
//  Created by m1 on 17/02/2022.
//

import Foundation

enum IntentStateListIngredient: CustomStringConvertible, Equatable {
    case ready
    case nameChanging(String)
    case uniteChanging(String)
    case unitPriceChanging(String)
    case availableQuantityChanging(String)
    
    var description: String {
        switch self {
        case .ready: return "state .ready"
        case .nameChanging(let name): return "nameChanging \(name)"
        case .uniteChanging(let unit): return "uniteChanging \(unit)"
        case .unitPriceChanging(let price): return "unitePriceChanging \(price)"
        case .availableQuantityChanging(let qty): return "availableQtyChanging \(qty)"
        }
    }
}

struct IntentListIngredient{
    
}
