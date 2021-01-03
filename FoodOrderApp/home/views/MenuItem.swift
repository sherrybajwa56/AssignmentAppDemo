//
//  MenuItem.swift
//  FoodOrderApp
//
//  Created by Sherry on 11/12/20.
//

import SwiftUI

struct MenuItem: View {
    @State private var selected = false
    @State private var itemQuantity = 0
    let dish: Dish
    var addToCartAction : ((Dish) -> Void)?
    var body: some View {
        ZStack {
            GeometryReader { g in
                VStack(alignment: .leading) {
                    RemoteImage(url: dish.image)
                        .frame( height: 250)
                        .clipped()
                    VStack(alignment: .leading)  {
                        Text(dish.name)
                            .font(.system(size: 16, weight: .bold))
                        Text(dish.description)
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.gray)
                        HStack {
                            Text("190 gm, 40 cm")
                                .font(.system(size: 12, weight: .medium))
                            Spacer()

                            Button(selected ? "added +\(itemQuantity)" : String(format:"%.2f USD" , dish.price)) {
                                selected = true
                                itemQuantity += 1
                                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                    selected = false
                                }
                                addToCartAction?(dish)
                                print("button clicked")
                            }
                            .font(.system(size: 14))
                            .padding()
                            .frame(height: 40)
                            .foregroundColor(.white)
                            .background(selected ? Color.green : Color.black)
                            .cornerRadius(30)
                        }.onTapGesture {
                            print("tapped on hstack")
                        }
                    }
                    .padding(20)
                }
                .background(Color.init(red:255, green:255, blue:255, opacity: 1))
            }

        }
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding()


    }
}

struct MenuItem_Previews: PreviewProvider {
    static var previews: some View {
        MenuItem(dish: Dish(id: "1", name: "A.D.’s Chicken Saltimbocca", price: 75.9, image: "http://restaurants.unicomerp.net/images/Restaurant/Item/Item_100000018.jpg", description: "Hello"))
    }
}
