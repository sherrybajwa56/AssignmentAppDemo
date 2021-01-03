//
//  Dish.swift
//  FoodOrderApp
//
//  Created by Sherry on 11/12/20.
//

import Foundation
import ObjectMapper
struct Menu {

    var id: String!

    var name: String!

    var image: String!

    var categories: [Category]!

}

struct Dish : Hashable{

    var id: String!

    var name: String!

    var price: Double!

    var image: String!

    var description: String!

}

struct Category: Hashable {
    static func == (lhs: Category, rhs: Category) -> Bool {
        return lhs.id > rhs.id
    }

    var id: String!

    var name: String!

    var image: String!

    var dishes: [Dish]!

}

enum FoodCategory: String, CaseIterable{
    case pizza
    case sushi
    case biryani
    case breakfast
    case drinks
}


struct Promotion: Identifiable {
    var id: Int
    var image: String
    var title: String
}

var promotionList = [
    Promotion(id: 0, image: "promo1", title: "hello"),
    Promotion(id: 1, image: "promo2", title: "hello"),
    Promotion(id: 2, image: "promo3", title: "hello")
]




