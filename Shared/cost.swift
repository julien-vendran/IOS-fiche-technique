//
//  cost.swift
//  fiche-technique-cuisine (iOS)
//
//  Created by m1 on 15/02/2022.
//

import Foundation
class Cost {

    var coutDesMatiere: Double
    var coutAssaisonnement: Double
    var coutDesCharges: Double
    var coutDesFluides: Double
    var coutDePersonnel: Double
    var coutDeProduction: Double
    var prixDeVente: Double {
        return self.coutDeProduction * 2.0
    }
    var beneficeParPortion: Double {
        return self.prixDeVente / 10
    }
    var seuilDeRentabilite: Double = 1.0

    init (
        coutDesMatiere: Double,
        coutDesFluides: Double,
        coutDePersonnel: Double,
        coutAssaisonnement: Double?
    ) {
        self.coutDesMatiere = coutDesMatiere
        self.coutAssaisonnement = (coutAssaisonnement != nil) ? coutAssaisonnement! : Double(coutDesMatiere) * 0.05
        self.coutDesFluides = coutDesFluides
        self.coutDePersonnel = coutDePersonnel
        self.coutDesCharges = coutDesFluides + coutDePersonnel
        self.coutDeProduction = coutDesMatiere+(self.coutDesCharges+self.coutAssaisonnement)
    }
}
