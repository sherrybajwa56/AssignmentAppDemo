//
//  ContentView.swift
//  FoodOrderApp
//
//  Created by Sherry on 11/12/20.
//

import SwiftUI
private let fullScreenHeightPC:CGFloat = 1
private let halfScreenHeightPC: CGFloat = 0.30

struct HomeScreen: ViewInterface, View {
    static let kMinHeight: CGFloat = 100.0
    var presenter: HomeScreenPresenterViewInterface!
    private var isFirstLoad = true
    @ObservedObject var viewModel: HomeScreenViewModel
    @State var corner_radius: CGFloat = 26
    @State var isActive = false
    @State var heightPC = halfScreenHeightPC
    init(presenter: HomeScreenPresenterViewInterface, viewModel: HomeScreenViewModel) {
        self.presenter = presenter
        self.viewModel = viewModel
        //start()
    }
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack(alignment: .bottom) {
                    VStack {
                        Carousel(promotions: promotionList)
                            .frame( height: heightPC < 0.5 ? geometry.size.height * (1.02 - heightPC) : geometry.size.height * (1.02 - halfScreenHeightPC) )
                        Spacer()
                    }

                    if viewModel.categories.count == 0 {

                    } else {
                        MenuContainer(categories: viewModel.categories, selection: viewModel.categories[0].id!, addToCartAction: { dish in
                            presenter?.addToCart(dish: dish)
                        })
                        .background(Color.white)
                        .cornerRadius(corner_radius)
                        .shadow(radius: 10)
                        .frame(width: geometry.size.width, height: heightPC * geometry.size.height)

                        .gesture (
                            DragGesture(minimumDistance: 80, coordinateSpace: .global)
                                .onChanged {value in
                                    let current_position_pc = value.location.y / geometry.size.height
                                    heightPC = (1 - current_position_pc ) //* geometry.size.height
                                }
                                .onEnded {value in
                                    let deltaY = value.startLocation.y - value.location.y
                                    print(deltaY)
                                    if(deltaY < 0) {
                                        //downward movement
                                        if abs(deltaY) > 100 {
                                            corner_radius = 10
                                            heightPC = halfScreenHeightPC //* geometry.size.height
                                        } else {
                                            corner_radius = 0
                                            heightPC = fullScreenHeightPC //* geometry.size.height
                                        }

                                    } else {
                                        //upward movement
                                        if deltaY > 100 {
                                            corner_radius = 0
                                            heightPC = fullScreenHeightPC //* geometry.size.height
                                        } else {
                                            corner_radius = 10
                                            heightPC = halfScreenHeightPC //* geometry.size.height
                                        }
                                    }
                                }
                        )
                        .animation(.easeIn(duration: 0.1))
                    }
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            NavigationLink(
                                destination:  CartScreen(cart: $viewModel.cartItems, onRemoveCart: { dish in
                                    presenter.removeFromCart(dish: dish)
                                }, isActive: $isActive)
                                .navigationBarHidden(true), isActive: $isActive
                            ) {
                                CartButton(cartCount: $viewModel.cartCount)
                                    .opacity(heightPC > 0.5 ? 1 : 0)
                                    .animation(.easeIn)
                                    .frame(width: 40, height: 40)
                                    .onTapGesture {
                                        isActive = true
                                    }
                            }
                        }
                        .padding()
                    }
                    .padding()
                }
            }
            .navigationBarHidden(true)
            .navigationTitle("Menu")
            .navigationBarColor(backgroundColor: .white, titleColor: .white)
            .onAppear {
                presenter.fetchCategories()
                presenter.fetchCartItems()
                if(isFirstLoad) {
                    start()
                }
            }
            .edgesIgnoringSafeArea(.top)
        }

    }

    func start() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            //self.menu_y_position_pc = initialPositionPC
            //self.caraousel_height_pc = initialPositionPC
        }
    }

}
