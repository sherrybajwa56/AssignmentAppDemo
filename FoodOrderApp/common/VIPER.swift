//
//  VIPER.swift
//  FoodOrderApp
//
//  Created by Sherry on 12/12/20.
//

import Foundation
// MARK: - VIPER

public protocol RouterInterface: RouterPresenterInterface {
    associatedtype PresenterRouter

    var presenter: PresenterRouter! { get set }
}

public protocol InteractorInterface: InteractorPresenterInterface {
    associatedtype PresenterInteractor

    var presenter: PresenterInteractor! { get set }
}

public protocol PresenterInterface: PresenterRouterInterface & PresenterInteractorInterface & PresenterViewInterface {
    associatedtype RouterPresenter
    associatedtype InteractorPresenter
//    associatedtype ViewPresenter

    var router: RouterPresenter! { get set }
    var interactor: InteractorPresenter! { get set }
//    var view: ViewPresenter! { get set }
}

public protocol ViewInterface/*: ViewPresenterInterface*/ {
    associatedtype PresenterView

    var presenter: PresenterView! { get set }
}

public protocol EntityInterface {

}

// MARK: - "i/o" transitions

public protocol RouterPresenterInterface: class {

}

public protocol InteractorPresenterInterface: class {

}

public protocol PresenterRouterInterface: class {

}

public protocol PresenterInteractorInterface: class {

}

public protocol PresenterViewInterface: class {

}

// MARK: - module

public protocol ModuleInterface {

    associatedtype View where View: ViewInterface
    associatedtype Presenter where Presenter: PresenterInterface
    associatedtype Router where Router: RouterInterface
    associatedtype Interactor where Interactor: InteractorInterface

    func assemble(/*view: View,*/ presenter: Presenter, router: Router, interactor: Interactor)
}

public extension ModuleInterface {

    func assemble(presenter: Presenter, router: Router, interactor: Interactor) {

//        mview.presenter = (presenter as! Self.MView.PresenterView)
//
//        presenter.view = (mview as! Self.Presenter.ViewPresenter)

        presenter.interactor = (interactor as! Self.Presenter.InteractorPresenter)
        presenter.router = (router as! Self.Presenter.RouterPresenter)

        interactor.presenter = (presenter as! Self.Interactor.PresenterInteractor)

        router.presenter = (presenter as! Self.Router.PresenterRouter)
    }
}
