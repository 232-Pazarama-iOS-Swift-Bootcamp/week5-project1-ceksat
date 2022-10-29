//
//  AdvertViewModel.swift
//  Ceksat
//
//  Created by Pazarama iOS Bootcamp on 29.10.2022.
//

import Foundation

protocol AdvertViewModelDelegate: AnyObject {
    func didErrorOccurred(_ error: Error)
    func didFetchProducts()
}

protocol AdvertViewModelProtocol {
    var delegate: AdvertViewModelDelegate? { get set }
    var numberOfRows: Int { get }
    func titleForRow(_ row: Int) -> String?
    func fetchProducts()
}

final class AdvertViewModel: AdvertViewModelProtocol, RealmReachable {
    weak var delegate: AdvertViewModelDelegate?
    
    private var products = [ProductEntity]() {
        didSet {
            delegate?.didFetchProducts()
        }
    }
    
    var numberOfRows: Int {
        products.count
    }
    
    func titleForRow(_ row: Int) -> String? {
        products[row].title
    }
    
    func fetchProducts() {
        products = realm.objects(ProductEntity.self).map { $0 }
    }
}
