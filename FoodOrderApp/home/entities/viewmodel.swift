//
//  viewmodel.swift
//  FoodOrderApp
//
//  Created by Sherry on 12/12/20.
//

import Combine
import SwiftUI

final class HomeScreenViewModel: ObservableObject {
    let objectWillChange = ObservableObjectPublisher()
    @Published var cartCount: Int = 0 {
        willSet {
            self.objectWillChange.send()
        }
    }
    @Published var categories: [Category] = [] {
       willSet {
            self.objectWillChange.send()
        }
    }

    @Published var cartItems: [String: (Dish, Int)] = [:] {
        willSet {
             self.objectWillChange.send()
        }

        didSet {
            cartCount = computedCart
        }
    }

    private var computedCart : Int {
        return cartItems.keys.reduce(0) { (count, key) -> Int in
            return count + (cartItems[key]?.1 ?? 0)
        }
    }
}
