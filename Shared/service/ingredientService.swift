//
//  ingredientService.swift
//  fiche-technique-cuisine (iOS)
//
//  Created by m1 on 22/02/2022.
//

import Foundation

class IngredientService {
    
    static var url_back : String = "https://fiche-technique-cuisine-back.herokuapp.com/ingredients/"
   
    
    public static func getIngredient(id : Int) async throws -> IngredientDTO? {
        var output : IngredientDTO? = nil
        if let url = URL(string: url_back+"\(id)"){
            output = try await URLSession.shared.getJSON(from: url)
        }
        return output
    }
    
    public static func getAllIngredient() async throws -> [IngredientDTO]{
        var output : [IngredientDTO] = []
        if let url = URL(string: url_back){
            output = try await URLSession.shared.getJSON(from: url)
        }
        return output
    }
    
    public static func saveIngredient(_ ingr: Ingredient) async {
        if let url = URL(string: url_back){
            var request = URLRequest(url: url)
            request.addValue("application/json", forHTTPHeaderField:"Content-Type")
          /*  request.addValue(ingr.name, forHTTPHeaderField: "name")
            request.addValue(ingr.unit, forHTTPHeaderField: "unit")
            request.addValue(ingr.unitPrice, forHTTPHeaderField: "unitPrice")
            request.addValue(ingr.availableQuantity, forHTTPHeaderField: "availableQuantity")*/
            let dto = IngredientDTO(id: nil, name: ingr.name, unit: ingr.unit, availableQuantity: ingr.availableQuantity, unitPrice: ingr.unitPrice, associatedAllergen: [], denreeUsed:[])
            request.httpMethod = "POST"
            let encoded = try? JSONEncoder().encode(dto)
            
            try? await URLSession.shared.upload(for: request, from:encoded!)
            
            
        }
    }
}
