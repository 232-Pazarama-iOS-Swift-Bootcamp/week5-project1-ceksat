//
//  AuthPresenter.swift
//  Ceksat
//
//  Created by Pazarama iOS Bootcamp on 23.10.2022.
//

import Foundation

protocol AuthInteractorToPresenterProtocol: AnyObject {
    func didUserCreated()
    func didErrorOccurred(_ error: Error)
}

final class AuthPresenter: AuthViewToPresenterProtocol {
    
    weak var view: AuthPresenterToViewProtocol?
    var interactor: AuthPresenterToInteractorProtocol?
    var router: AuthPresenterToRouterProtocol?
    
    func didUserCreated() {
        print("User created.")
    }
    
    func didErrorOccurred(_ error: Error) {
        print(error)
    }
}

extension AuthPresenter: AuthInteractorToPresenterProtocol {
    
}
