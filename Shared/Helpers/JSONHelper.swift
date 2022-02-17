//
//  JSONHelper.swift
//  fiche-technique-cuisine (iOS)
//
//  Created by m1 on 17/02/2022.
//

import Foundation

struct JSONHelpler {
    static func decode <T: Decodable> (model: T, data: Data) -> T? {
        let decoder = JSONDecoder()
        if let decoded = try? decoder.decode(T.self, from: data) {
            return decoded
        }
        return nil
    }
}
