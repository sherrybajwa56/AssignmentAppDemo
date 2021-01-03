//
//  CartScreen.swift
//  FoodOrderApp
//
//  Created by Sherry on 13/12/20.
//

import SwiftUI

struct CartScreen: View {
    @State private var selection = "cart"
    @Binding var cart: [String: (Dish, Int)]
    var onRemoveCart: ((Dish) -> Void)? = nil
    @Binding var isActive: Bool
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing:0) {
                Image("back")
                    .resizable()
                    .frame(width: 12, height: 12, alignment: .center)
                    .padding(.leading, 5)
                    .padding(.trailing, 4)
                Text("Menu")
                    .font(.system(size: 14, weight: .medium))
            }.onTapGesture {
                isActive = false
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    MenuTab(name: "Cart", id: "cart", selection: $selection )
                    MenuTab(name: "Orders", id: "orders", selection: $selection )
                    MenuTab(name: "Information", id: "information", selection: $selection )
                }
            }
            TabView(selection: $selection) {
                VStack {
                    ForEach(cart.keys.sorted(), id: \.self) { key in
                        if cart[key]!.1 > 0 {
                            CartItem(dish: cart[key]!.0, quantity: cart[key]!.1, onRemoveCart: { removedish in
                                onRemoveCart?(removedish)
                                print("remove dish")
                            })
                        }

                    }
                    Spacer()
                }.onAppear {
                    selection = "cart"
                }
                VStack {
                    Text("Work in progress")
                }
                .onAppear {
                    selection = "orders"
                }
                VStack {
                    Text("Work in progress")
                }
                .onAppear {
                    selection = "information"
                }
            }
            .tabViewStyle(PageTabViewStyle())

            Spacer()
        }

    }
}

struct CartScreen_Previews: PreviewProvider {
    @State static var cart: [String: (Dish, Int)] = [ "1": (
        Dish(id: "1", name: "A.D.’s Chicken Saltimbocca", price: 75.9, image: "http://restaurants.unicomerp.net/images/Restaurant/Item/Item_100000018.jpg", description: "Hello"), 1)
    ]
    @State static var isActive = true
    static var previews: some View {
        NavigationView {
            ZStack {
                CartScreen(cart: $cart, isActive: $isActive)
                    .navigationBarHidden(true)
                
            }

        }
    }
}
