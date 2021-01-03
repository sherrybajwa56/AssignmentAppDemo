//
//  CarouselView.swift
//  FoodOrderApp
//
//  Created by Sherry on 11/12/20.
//

import SwiftUI

struct Carousel: View {
    var promotions:[Promotion]
    @State var selection : Int = -1
    @State var opacity: Double = 0.0
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    var body: some View {
        GeometryReader { geometry in
            TabView(selection: $selection) {
                ForEach(0..<promotions.count) { index in
                    ZStack {
                        Color.black
                        HStack(spacing:0){
                            Image(promotions[index].image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                //.border(Color.red, width:5)
                                .frame(width: geometry.size.width, height: geometry.size.height)
                                .animation(.linear)
                        }

                    }
                    .offset(x: 0, y: -(UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0))
                    .edgesIgnoringSafeArea(.top)
                    .tag(index)
                }

            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.45) {
                    opacity = 1
                }
            }
            .frame(width: geometry.size.width)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
            .onReceive(timer, perform: { timer in
                selection = (selection + 1) % promotions.count
            })
            .opacity(opacity)
            .animation(.easeInOut)

        }
    }

}

struct Carousel_Previews: PreviewProvider {
    static var previews: some View {
        Carousel(promotions: promotionList)
    }
}
