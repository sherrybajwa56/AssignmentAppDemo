//
//  CartItem.swift
//  FoodOrderApp
//
//  Created by Sherry on 12/12/20.
//

import SwiftUI

struct CartItem: View {
    var dish: Dish
    var quantity: Int
    var onRemoveCart: ((Dish) -> Void)? = nil
    var body: some View {
        HStack(alignment:.center){
            RemoteImage(url: dish.image)
                .frame(width: 50, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .clipped()
            Text(dish.name)
                .font(.system(size: 14, weight:.medium))
            Text("x \(quantity)")
                .font(.system(size: 10, weight:.medium))
            Spacer()
            Text(String(format: "%.2f Usd", dish.price * Double(quantity)))
                .font(.system(size: 12, weight:.medium))
            Button(action: {
                onRemoveCart?(dish)
            }, label: {
                Image("cancel")
            })
        }.padding(10)
    }
}

struct CartItem_Previews: PreviewProvider {
    static var previews: some View {
        CartItem(dish: Dish(id: "1", name: "Dummy", price: 22.0, image: "hello", description: "Description here"),quantity: 1)
    }
}
