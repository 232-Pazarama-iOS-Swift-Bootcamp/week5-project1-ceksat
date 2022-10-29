//
//  AuthViewModel.swift
//  Ceksat
//
//  Created by Pazarama iOS Bootcamp on 23.10.2022.
//

import Foundation
import RealmSwift

protocol AuthViewModelDelegate: AnyObject {
    func didUserCreated()
    func didErrorOccurred(_ error: Error)
    func didSignInSusccesful(_ isSuccessful: Bool)
}

final class AuthViewModel {
    
    weak var delegate: AuthViewModelDelegate?
    
    private let realm = try! Realm()
    
    func signUp(_ user: User) {
        
        let users = realm.objects(User.self)
        
        let fetchedUser = users.where { $0.username == user.username }
        
        if fetchedUser.count > .zero {
            print("You can't use this user name.")
            return
        }
        
        do {
            try realm.write {
                realm.add(user)
                self.delegate?.didUserCreated()
            }
        } catch {
            delegate?.didErrorOccurred(error)
        }
    }
    
    func signInWithUserName(_ username: String, andPassword password: String) {
        let users = realm.objects(User.self)
        
        let user = users.where { user in
            user.username == username
        }
        
        delegate?.didSignInSusccesful(user.first?.password == password)
    }
}
