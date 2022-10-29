//
//  RealmReacheable.swift
//  Ceksat
//
//  Created by Pazarama iOS Bootcamp on 29.10.2022.
//

import Foundation
import RealmSwift

protocol RealmReachable { }

extension RealmReachable {
    var realm: Realm { try! Realm() }
}
