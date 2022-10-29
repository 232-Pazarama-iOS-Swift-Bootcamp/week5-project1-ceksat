//
//  AdvertViewModel.swift
//  Ceksat
//
//  Created by Pazarama iOS Bootcamp on 29.10.2022.
//

import Foundation

protocol AdvertInteractorDelegate: AnyObject {
    func didErrorOccurred(_ error: Error)
    func didFetchProducts()
}

final class AdvertInteractor: RealmReachable {
    weak var delegate: AdvertInteractorDelegate?
    
    private(set) var products = [ProductEntity]() {
        didSet {
            delegate?.didFetchProducts()
        }
    }
    
    func fetchProducts() {
        products = realm.objects(ProductEntity.self).map { $0 }
    }
}
