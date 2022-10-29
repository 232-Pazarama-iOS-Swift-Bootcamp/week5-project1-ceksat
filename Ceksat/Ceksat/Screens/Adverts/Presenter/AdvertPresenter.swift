//
//  AdvertPresenter.swift
//  Ceksat
//
//  Created by Pazarama iOS Bootcamp on 29.10.2022.
//

import Foundation

protocol AdvertPresenterDelegate: AnyObject {
    func didErrorOccurred(_ error: Error)
    func didFetchProducts()
}

final class AdvertPresenter {
    weak var delegate: AdvertPresenterDelegate?
    
    var interactor: AdvertInteractor
    var router: AdvertRouter?
    weak var view: AdvertViewController? {
        didSet {
            router = AdvertRouter(navigationController: view?.navigationController)
        }
    }
    
    var numberOfRows: Int {
        interactor.products.count
    }
    
    init(interactor: AdvertInteractor) {
        self.interactor = interactor
        self.interactor.delegate = self
    }
    
    func titleForRow(_ row: Int) -> String? {
        interactor.products[row].title
    }
    
    func fetchProducts() {
        interactor.fetchProducts()
    }
    
    func goToDetailFor(_ row: Int) {
        let product = interactor.products[row]
        router?.goToDetailFor(product)
    }
}

// MARK: - AdvertInteractorDelegate
extension AdvertPresenter: AdvertInteractorDelegate {
    func didErrorOccurred(_ error: Error) {
        delegate?.didErrorOccurred(error)
    }
    
    func didFetchProducts() {
        delegate?.didFetchProducts()
    }
}
