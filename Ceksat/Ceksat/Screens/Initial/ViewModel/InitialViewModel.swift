//
//  InitialViewModel.swift
//  Ceksat
//
//  Created by Pazarama iOS Bootcamp on 29.10.2022.
//

import Foundation
import CeksatAPI

protocol InitialViewModelDelegate: AnyObject {
    func didErrorOccurred(_ error: Error)
    func didFetchProducts()
}

final class InitialViewModel: RealmReachable {
    weak var delegate: InitialViewModelDelegate?
    
    func fetchProducts() {
        fakeStoreServiceProvider.request(.getProducts) { result in
            switch result {
            case .failure(let error):
                self.delegate?.didErrorOccurred(error)
            case .success(let response):
                do {
                    let products = try JSONDecoder().decode([Product].self, from: response.data)
                    
                    products.forEach { product in
                        
                        guard self.realm.object(ofType: ProductEntity.self, forPrimaryKey: product.id) == nil else {
                            return
                        }
                        
                        let productEntity = ProductEntity()
                        productEntity._id = product.id ?? .zero
                        productEntity.title = product.title!
                        productEntity.price = product.price!
                        productEntity.desc = product.description!
                        productEntity.category = product.category!
                        productEntity.image = product.image!
                        
                        let ratingEntity = RatingEntity()
                        ratingEntity.rate = product.rating!.rate!
                        ratingEntity.count = product.rating!.count!
                        
                        productEntity.rating = ratingEntity
                        
                        do {
                            try self.realm.write {
                                self.realm.add(productEntity)
                            }
                        } catch {
                            self.delegate?.didErrorOccurred(error)
                        }
                    }
                    self.delegate?.didFetchProducts()
                } catch {
                    self.delegate?.didErrorOccurred(error)
                }
            }
        }
    }
}
