//
//  repo.swift
//  FoodOrderApp
//
//  Created by Sherry on 12/12/20.
//

import Foundation
import RxSwift
import RxRelay
import Moya
import Moya_ObjectMapper

struct StubMenuRepository : MenuRepositoryInterface {
    private let provider = MoyaProvider<RestaurentMenuService>(stubClosure: MoyaProvider.immediatelyStub)

    func getMenu(restaurentId: String) -> Single<Menu> {
        return provider.rx.request(.getMenu(restaurentId: restaurentId))
            .mapObject(Menu.self)
            .map{ $0 }
    }
}

struct RemoteMenuRepository : MenuRepositoryInterface {
    private let provider = MoyaProvider<RestaurentMenuService>()

    func getMenu(restaurentId: String) -> Single<Menu> {
        return provider.rx.request(.getMenu(restaurentId: restaurentId))
            .mapObject(Menu.self)
            .map{ $0 }
    }
}

fileprivate struct MemCart {
    static let shared = MemCart()
    let dishes: BehaviorRelay<[String: (Dish, Int)]> = BehaviorRelay(value: [:])
}


struct MemCartRepository : CartRepositoryInterface {

    func add(dish: Dish) {
        var dishCount = 0
        if let tuple = MemCart.shared.dishes.value[dish.id!] {
            //already exists
            dishCount = tuple.1
        }
        dishCount += 1
        let newValue: (Dish, Int) = (dish, dishCount)
        MemCart.shared.dishes.accept(MemCart.shared.dishes.value.merging([dish.id!: newValue]) {_, new in
            new
        })
    }

    func remove(dish: Dish) {
        var dishCount = 0
        if let tuple = MemCart.shared.dishes.value[dish.id!] {
            //already exists
            dishCount = tuple.1
        }
        if(dishCount > 0) {
            dishCount -= 1
        }
        let newValue: (Dish, Int) = (dish, dishCount)
        MemCart.shared.dishes.accept(MemCart.shared.dishes.value.merging([dish.id!: newValue]) {_, new in
            new
        })
    }

    func getItems() -> BehaviorRelay<[String: (Dish, Int)]> {
        return MemCart.shared.dishes
    }

}
