//
//  alergen.swift
//  fiche-technique-cuisine (iOS)
//
//  Created by m1 on 15/02/2022.
//

import Foundation

struct AllergenObserver {
}

class Allergen {
    
    var id : Int?
    var name : String
    
    init(id: Int?, name: String){
        self.id = id
        self.name = name
    }
    
}
