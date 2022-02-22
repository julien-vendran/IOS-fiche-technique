//
//  AllergenDTO.swift
//  fiche-technique-cuisine (iOS)
//
//  Created by m1 on 17/02/2022.
//

import Foundation

struct AllergenDTO : Codable {
    var id_Allergen: Int?
    var allergen_name: String
    
    var allergen: Allergen {
        return Allergen(id: id_Allergen, name: allergen_name)
    }
}
