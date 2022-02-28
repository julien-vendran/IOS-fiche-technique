//
//  StepDTO.swift
//  fiche-technique-cuisine (iOS)
//
//  Created by m1 on 26/02/2022.
//

import Foundation

struct StepDTO: Decodable, Encodable {
    var id : Int?
    var name : String
    var description: String
    var duration: Double
    var denreeUsed: [DenreeDTO]
    
    var step: Step {
        let list_denree: [Denree] = self.denreeUsed.compactMap {
            (dto: DenreeDTO) -> Denree in
            return dto.denree
        }
        return Step(name: self.name, description: self.description, duration: self.duration, denreeUsed: list_denree, id: self.id)
    }
}
