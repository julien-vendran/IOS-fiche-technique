//
//  cost.swift
//  fiche-technique-cuisine (iOS)
//
//  Created by m1 on 15/02/2022.
//

import Foundation
class Cost {

    var coutDesMatiere: Int
    var coutAssaisonnement: Int
    var coutDesCharges: Int
    var coutDesFluides: Int
    var coutDePersonnel: Int
    var coutDeProduction: Int
    var prixDeVente: Int
    var beneficeParPortion: Int
    var seuilDeRentabilite: Int

    init (
        coutDesMatiere: Int,
        coutDesFluides: Int,
        coutDePersonnel: Int,
        coutAssaisonnement: Int?,
    ) {
        self.coutDesMatiere = coutDesMatiere
        self.coutAssaisonnement = coutAssaisonnement ? coutAssaisonnement : coutDesMatiere * 0.05
        self.coutDesFluides = coutDesFluides
        self.coutDePersonnel = coutDePersonnel
        self.coutDesCharges = coutDesFluides + coutDePersonnel
        self.coutDeProduction = coutDesMatiere + self.coutDesCharges +self.coutAssaisonnement
        self.prixDeVente = self.coutDeProduction * 2
    }
}
