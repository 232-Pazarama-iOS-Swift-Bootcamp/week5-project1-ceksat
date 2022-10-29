//
//  RatingEntity.swift
//  Ceksat
//
//  Created by Pazarama iOS Bootcamp on 29.10.2022.
//

import Foundation
import RealmSwift

class RatingEntity: Object {
    @Persisted var rate: Double
    @Persisted var count: Int
}
