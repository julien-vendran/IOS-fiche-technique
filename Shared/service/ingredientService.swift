//
//  ingredientService.swift
//  fiche-technique-cuisine (iOS)
//
//  Created by m1 on 22/02/2022.
//

import Foundation

class IngredientService {
    
    static var url_back : String = "https://fiche-technique-cuisine-back.herokuapp.com/ingredients/"
    
    public static func getIngredient(id : Int) async  -> Ingredient? {
        var output : Ingredient? = nil
        do{
            if let url = URL(string: url_back+"\(id)"){
                let decoded : IngredientDTO = try await URLSession.shared.getJSON(from: url)
                output = decoded.ingredient
                
            }
        }catch let error{
            print(error.localizedDescription)
        }
        return output
    }
    
    public static func getAllIngredient() async  -> [Ingredient]{
        var output : [Ingredient] = []
        do{
            if let url = URL(string: url_back){
                let decoded : [IngredientDTO] = try await URLSession.shared.getJSON(from: url)
                output = decoded.compactMap{ (dto: IngredientDTO) -> Ingredient in
                    return dto.ingredient
                }
            }
        } catch let error {
            print(error.localizedDescription)
        }
        return output
    }
    
    public static func saveIngredient(_ ingr: Ingredient) async -> Ingredient? {
        if let url = URL(string: url_back){
            var request = URLRequest(url: url)
            request.addValue("application/json", forHTTPHeaderField:"Content-Type")
            let associatedAllergenDTO = ingr.associatedAllergen.compactMap{ (al : Allergen) -> AllergenDTO in
                return AllergenDTO(id_Allergen: al.id, allergen_name: al.name)
            }
            let dto = IngredientDTO(id: nil, name: ingr.name, unit: ingr.unit, availableQuantity: ingr.availableQuantity, unitPrice: ingr.unitPrice, associatedAllergen: associatedAllergenDTO /*, denreeUsed:[]*/)
            request.httpMethod = "POST"
            do{
                
                let encoded = try JSONEncoder().encode(dto)
                let addedValue = try await URLSession.shared.upload(for: request, from: encoded)
                let addedIngredient: IngredientDTO? = JSONHelpler.decode(data: addedValue.0)
                if (addedIngredient != nil) {
                    return addedIngredient!.ingredient
                } else {
                    return nil
                }
            }catch  let error {
                print(error.localizedDescription)
            }
            
        }
        return nil
    }
    
    public static func deletIngredient(id: Int) async {
        if let url = URL(string: url_back+"\(id)"){
            var request = URLRequest(url: url)
            request.httpMethod="DELETE"
            do{
                let _ = try await URLSession.shared.data(for: request)
            }catch let error{
                print(error.localizedDescription)
            }
        }
    }
    
    public static func updateIngredient(_ ingr: Ingredient) async {
        if let url = URL(string: "\(url_back)\(ingr.id!)") {
            var request = URLRequest(url: url)
            request.addValue("application/json", forHTTPHeaderField:"Content-Type")
            request.httpMethod = "PATCH"
            
            let associatedAllergenDTO = ingr.associatedAllergen.compactMap{ (al : Allergen) -> AllergenDTO in
                return AllergenDTO(id_Allergen: al.id, allergen_name: al.name)
            }
            let dto = IngredientDTO(id: ingr.id, name: ingr.name, unit: ingr.unit, availableQuantity: ingr.availableQuantity, unitPrice: ingr.unitPrice, associatedAllergen: associatedAllergenDTO)
            
            do{
                
                let encoded = try JSONEncoder().encode(dto)
                let _ = try await URLSession.shared.upload(for: request, from: encoded)
                
            }catch  let error {
                print(error.localizedDescription)
            }
            
        }
    }
}
