//
//  objectmapper.swift
//  FoodOrderApp
//
//  Created by Sherry on 12/12/20.
//

import Foundation
import ObjectMapper

extension Menu: Mappable {
    init?(map: Map) {
        self.init()
    }

    mutating func mapping(map: Map) {
        id          <- map["id"]
        name        <- map["name"]
        image       <- map["image"]
        categories        <- map["menu"]
    }
}

extension Dish: Mappable {
    init?(map: Map) {
        self.init()
    }

    mutating func mapping(map: Map) {
        id              <- map["id"]
        name            <- map["name"]
        image           <- map["image"]
        price           <- map["price"]
        description     <- map["description"]
    }
}

extension Category: Mappable {
    init?(map: Map) {
        self.init()
    }

    mutating func mapping(map: Map) {
        id          <- map["id"]
        name        <- map["name"]
        image       <- map["image"]
        dishes      <- map["dishes"]
    }
}


