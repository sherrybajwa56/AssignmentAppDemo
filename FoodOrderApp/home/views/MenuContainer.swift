//
//  MenuView.swift
//  FoodOrderApp
//
//  Created by Sherry on 11/12/20.
//

import SwiftUI

struct MenuTab: View {
    var name: String
    var id: String
    @Binding var selection : String
    var body: some View {
        VStack {
            Text(name)
                .font(.system(size: id == selection ? 25 : 24, weight: .bold))
                .foregroundColor(id == selection ? .black : .gray)
                .onTapGesture {
                    selection = id
                }
                .padding(.leading, 10)
                .padding(.top, 10)
        }

            //.animation(.easeIn)

    }
}



struct MenuContainer: View {
    let categories: [Category]
    @State var selection: String
    var addToCartAction : ((Dish) -> Void)?
    var body: some View {
        ZStack {
            VStack {
                ScrollViewReader { scrollProxy in
                    VStack {
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack {
                                ForEach(categories, id: \.id!)  { category in
                                    MenuTab(name: category.name!,
                                            id: category.id!, selection: $selection)
                                }
                            }
                        }
                        .frame(height: 50)
                        
                    }
                    .padding(.top, 30)


                    TabView(selection: $selection ) {
                        ForEach(categories, id: \.id!) { category in
                            ScrollView(.vertical) {
                                LazyVStack(spacing: 0) {
                                    ForEach(category.dishes, id: \.id!) { dish in
                                        MenuItem(dish: dish, addToCartAction: { selectedDish in
                                            addToCartAction?(selectedDish)
                                        }).frame(minHeight: 400)
                                    }
                                }

                            }
                            .tag(category.id!)
                            .onAppear {
                                scrollProxy.scrollTo(category.id!)
                            }
                        }

                    }
                    .tabViewStyle(PageTabViewStyle())
                }
            }

        }
    }
}

struct MenuContainer_Previews: PreviewProvider {
    static var previews: some View {
        MenuContainer(categories: [], selection: "id")
    }
}
