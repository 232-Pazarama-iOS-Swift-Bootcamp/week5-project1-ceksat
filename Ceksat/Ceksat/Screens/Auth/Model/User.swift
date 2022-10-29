//
//  User.swift
//  Ceksat
//
//  Created by Pazarama iOS Bootcamp on 23.10.2022.
//

import Foundation
import RealmSwift

class User: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var username: String
    @Persisted var email: String
    @Persisted var gender: String
    @Persisted var birthDay: String
    @Persisted var password: String
}
