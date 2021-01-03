//
//  CartButton.swift
//  FoodOrderApp
//
//  Created by Sherry on 12/12/20.
//

import SwiftUI
import Combine

struct CartButton: View {
    @Binding var cartCount: Int
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                Image("add_to_cart")
                    .resizable()
                    .scaledToFit()
                    .padding(10)
                    .background(Color.white)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 1))
                    .shadow(color: .gray, radius: 10, x: 2, y: 5)
                if(cartCount > 0) {
                    Text("\(cartCount)")
                        .font(.system(size: 8))
                        .padding(5)
                        .foregroundColor(.white)
                        .background(Color.red)
                        .clipShape(Circle())
                        .offset(x: geometry.size.width/2 * 0.8, y: -geometry.size.height/2 * 0.8)
                }
            }
        }
    }
}

