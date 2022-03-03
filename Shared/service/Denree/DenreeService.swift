//
//  DenreeService.swift
//  fiche-technique-cuisine (iOS)
//
//  Created by m1 on 26/02/2022.
//

import Foundation

class DenreeService {
    
    private static var url_back = "https://fiche-technique-cuisine-back.herokuapp.com/denree/"
    private static var url = URL(string: url_back)
    
    
    public static func getDenree(id : Int) async  -> Denree? {
        var output : Denree? = nil
        do{
            if let url = URL(string: url_back+"\(id)"){
                let decoded : DenreeReadDTO = try await URLSession.shared.getJSON(from: url)
                //Pour chaque element dto on converti, compactMap =map mais plus simple
                output = decoded.denree
                
            }
        }catch let error{
            print("ERRORRRRRRRRRRRRRRRRRRRRRRRRrrr")
            print(error)
        }
        print("yes !!!!!!!!!!! \(output)")
        return output
    }
    
    static func createDenreeDTO(_ denree: Denree) -> DenreeDTO { //Initialise dto.step à nil
        let denree_i: Ingredient = denree.ingredient!
        let tab_allergen_DTO: [AllergenDTO] = denree_i.associatedAllergen.compactMap {
            (al: Allergen) -> AllergenDTO in
            return AllergenDTO(id_Allergen: al.id, allergen_name: al.name)
        }
        let ingredient_DTO: IngredientDTO = IngredientDTO(id: denree_i.id, name: denree_i.name, unit: denree_i.unit, availableQuantity: denree_i.availableQuantity, unitPrice: denree_i.unitPrice, associatedAllergen: tab_allergen_DTO)
        let denree_DTO: DenreeDTO = DenreeDTO(quantity: denree.quantity, ingredient: ingredient_DTO, step: nil, id: denree.id)
        
        return denree_DTO
    }
    
    static func createDenree(_ denree: Denree) async -> Denree? {
        if let url_back = self.url {
            var request = URLRequest(url: url_back)
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let denree_DTO: DenreeDTO = DenreeService.createDenreeDTO(denree)
            request.httpMethod = "POST"
            do {
                let encoded = try JSONEncoder().encode(denree_DTO)
                let addedValue = try await URLSession.shared.upload(for: request, from: encoded)
                let newDenree: DenreeDTO? = JSONHelpler.decode(data: addedValue.0)
                if (newDenree != nil) {
                    return newDenree!.denree
                } else {
                    return nil
                }

            } catch let error {
                print(error)
            }
        }
        return nil
    }
}
