//
//  interfaces.swift
//  FoodOrderApp
//
//  Created by Sherry on 12/12/20.
//

import Foundation
import RxSwift
import RxRelay
// MARK: - router
protocol HomeScreenRouterPresenterInterface: RouterPresenterInterface {

}

// MARK: - presenter
protocol HomeScreenPresenterRouterInterface: PresenterRouterInterface {

}

protocol HomeScreenPresenterInteractorInterface: PresenterInteractorInterface {

}

protocol HomeScreenPresenterViewInterface: PresenterViewInterface {
    func fetchCategories()
    func fetchCartItems()
    func addToCart(dish: Dish)
    func removeFromCart(dish: Dish)
}

// MARK: - interactor

protocol HomeScreenInteractorPresenterInterface: InteractorPresenterInterface {
    func getMenu() -> Single<Menu>
    func addToCart(dish: Dish)
    func removeFromCart(dish: Dish)
    func getCartItems () -> Observable<[String: (Dish, Int)]>
}

// MARK: - module builder

final class HomeScreenModule: ModuleInterface {
    typealias View = HomeScreen
    typealias Presenter = HomeScreenPresenter
    typealias Router = HomeScreenRouter
    typealias Interactor = HomeScreenInteractor
    func build() -> View {
        let presenter = Presenter()
        let interactor = Interactor(menuRepository:  StubMenuRepository(), cartRepositoty:  MemCartRepository())
        let router = Router()
        let viewModel = HomeScreenViewModel()
        let view = View(presenter: presenter, viewModel: viewModel)
        presenter.viewModel = viewModel
        self.assemble(presenter: presenter, router: router, interactor: interactor)
        return view
    }
}

final class HomeScreenPresenter: PresenterInterface {
    var router : HomeScreenRouterPresenterInterface!
    var  interactor : HomeScreenInteractorPresenterInterface!
    weak var viewModel: HomeScreenViewModel!
}

extension HomeScreenPresenter: HomeScreenPresenterRouterInterface {

}
extension HomeScreenPresenter: HomeScreenPresenterInteractorInterface {

}
extension HomeScreenPresenter: HomeScreenPresenterViewInterface {
    func fetchCategories() {
        interactor.getMenu().asObservable()
            .subscribe(onNext: { menu in
                self.viewModel.categories = menu.categories
            })
            .disposed(by: DisposeBag())
    }

    func fetchCartItems() {
        interactor.getCartItems().asObservable()
            .subscribe(onNext: { cart in
                self.viewModel.cartItems = cart
            })
            .disposed(by: DisposeBag())
    }

    func addToCart(dish: Dish) {
        interactor.addToCart(dish: dish)
        interactor.getCartItems().asObservable()
            .subscribe(onNext: { cart in
                self.viewModel.cartItems = cart
            })
            .disposed(by: DisposeBag())
    }

    func removeFromCart(dish: Dish) {
        interactor.removeFromCart(dish: dish)
        interactor.getCartItems().asObservable()
            .subscribe(onNext: { cart in
                self.viewModel.cartItems = cart
            })
            .disposed(by: DisposeBag())
    }
}

final class HomeScreenRouter: RouterInterface {
    var presenter: HomeScreenPresenterRouterInterface!
}
extension HomeScreenRouter: HomeScreenRouterPresenterInterface {

}


protocol MenuRepositoryInterface {
    func getMenu(restaurentId: String) -> Single<Menu>
}

protocol CartRepositoryInterface {
    func add(dish: Dish)
    func remove(dish: Dish)
    func getItems() -> BehaviorRelay<[String: (Dish, Int)]>
}

final class HomeScreenInteractor: InteractorInterface {
    private let menuRepositoty: MenuRepositoryInterface
    private let cartRepositoty: CartRepositoryInterface
    weak var presenter: HomeScreenPresenterInteractorInterface!
    init(menuRepository: MenuRepositoryInterface, cartRepositoty: CartRepositoryInterface) {
        self.menuRepositoty = menuRepository
        self.cartRepositoty = cartRepositoty
    }
}
extension HomeScreenInteractor: HomeScreenInteractorPresenterInterface {
    func getMenu() -> Single<Menu> {
        menuRepositoty.getMenu(restaurentId: "qwerty")
    }

    func addToCart(dish: Dish) {
        cartRepositoty.add(dish: dish)
    }

    func removeFromCart(dish: Dish) {
        cartRepositoty.remove(dish: dish)
    }

    func getCartItems() -> Observable<[String: (Dish, Int)]> {
        return cartRepositoty.getItems().asObservable()
    }
}

