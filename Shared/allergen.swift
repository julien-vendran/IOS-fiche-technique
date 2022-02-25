//
//  alergen.swift
//  fiche-technique-cuisine (iOS)
//
//  Created by m1 on 15/02/2022.
//

import Foundation

struct AllergenObserver {
}

struct Allergen : Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    
    var id : Int?
    var name : String
    
    init(id: Int?, name: String){
        self.id = id
        self.name = name
    }
    
}
