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
                //Pour chaque element dto on converti, compactMap =map mais plus simple
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
                //Pour chaque element dto on converti, compactMap =map mais plus simple
                output = decoded.compactMap{ (dto: IngredientDTO) -> Ingredient in
                    return dto.ingredient
                }
     
            }
        }catch let error{

            print(error.localizedDescription)
        }
        return output
    }
    
    public static func saveIngredient(_ ingr: Ingredient) async -> Ingredient? {
        if let url = URL(string: url_back){
            var request = URLRequest(url: url)
            request.addValue("application/json", forHTTPHeaderField:"Content-Type")
            let dto = IngredientDTO(id: nil, name: ingr.name, unit: ingr.unit, availableQuantity: ingr.availableQuantity, unitPrice: ingr.unitPrice, associatedAllergen: []/*, denreeUsed:[]*/)
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
                print("ingredientService : \(id) supprimé")
            }catch let error{
                print(error.localizedDescription)
            }
        }
    }
}
