//
//  Interactor.swift
//  Viper
//
//  Created by IDN MEDIA on 30/04/21.
//

import Foundation


// Object
// Protocol
// ref to presenter

// https://jsonplaceholder.typicode.com/users


protocol AnyInteractor {
    var presenter: AnyPresenter? { get set }
    
    func getUsers()
}

class UserInteractor: AnyInteractor {
    var presenter: AnyPresenter?
    
    func getUsers() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                self?.presenter?.interactorDidGetchUsers(with: .failure(FetchError.failed))
                return
            }
            do {
                let entities = try JSONDecoder().decode([User].self, from: data)
                self?.presenter?.interactorDidGetchUsers(with: .success(entities))
            }
            catch {
                self?.presenter?.interactorDidGetchUsers(with: .failure(error))
            }
        }
        task.resume()
    }
    
    
}
