//
//  CostDTO.swift
//  fiche-technique-cuisine (iOS)
//
//  Created by m1 on 04/03/2022.
//

import Foundation

struct CostDTO : Codable {
    var coutMatiere : Double
    var coutCharges : CoutChargeDTO
    
    var cout :Cost {
        return Cost(coutDesMatiere: self.coutMatiere, coutDesFluides: self.coutCharges.fluides, coutDePersonnel: self.coutCharges.fluides, coutAssaisonnement: nil)
    }
}

struct CoutChargeDTO : Codable {
    var personnel : Double
    var fluides : Double
}
