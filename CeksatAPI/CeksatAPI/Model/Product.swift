//
//  Product.swift
//  Ceksat
//
//  Created by Pazarama iOS Bootcamp on 29.10.2022.
//

import Foundation

public struct Product: Decodable {
    let id: Int?
    let title: String?
    let price: Double?
    let description: String?
    let category: String?
    let image: String?
    let rating: Rating?
}

public struct Rating: Decodable {
    let rate: Double?
    let count: Int?
}
