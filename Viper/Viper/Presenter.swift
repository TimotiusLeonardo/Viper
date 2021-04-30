//
//  Presenter.swift
//  Viper
//
//  Created by IDN MEDIA on 30/04/21.
//

import Foundation

// Object
// Protocol
// ref to interactor, router, view

enum FetchError: Error {
    case failed
}

protocol AnyPresenter {
    var router: AnyRouter? { get set }
    var interactor: AnyInteractor? { get set }
    var view: AnyView? { get set }
    
    func interactorDidGetchUsers(with result: Result<[User], Error>)
}

class UserPresenter: AnyPresenter {
    var view: AnyView?
    
    func interactorDidGetchUsers(with result: Result<[User], Error>) {
        switch result {
        case .success(let users):
            view?.update(with: users)
        case .failure:
            view?.update(with: "Something went wrong")
        }
    }
    
    var router: AnyRouter?
    
    var interactor: AnyInteractor? {
        didSet {
            interactor?.getUsers()
        }
    }
    
}
