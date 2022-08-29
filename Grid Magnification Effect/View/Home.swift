//
//  Home.swift
//  Grid Magnification Effect
//
//  Created by Антон Кулик on 28.08.2022.
//

import SwiftUI

struct Home: View {
    //MARK: Gesture State
    @GestureState var location: CGPoint = .zero
    var body: some View {
        GeometryReader{ proxy in
            let size = proxy.size
            //MARK: To Fit Into Whole View
            //Calculating Item Count with the help of Height & Width
            //In a Row We Have 10 Items
            let width = (size.width / 10)
            let itemCount = Int((size.height / width).rounded()) * 10
            
            //MARK: For Solid Linear Gradient
            // We're Going to Use Mask
            LinearGradient(colors: [.cyan, .yellow, .mint, .pink, .purple], startPoint: .topLeading, endPoint: .bottomTrailing)
                .mask {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 0), count: 10), spacing: 0) {
                        ForEach(0..<itemCount,id:\.self) {_ in
                            GeometryReader{innerProxy in
                                let rect = innerProxy.frame(in: .named("GESTURE"))
                                let scale = itemScale(rect: rect, size: size)
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(.orange)
                                    .scaleEffect(scale)
                            }
                            .padding(5)
                            .frame(height: width)
                            
                        }
                    }
                }
            
        }
        .padding(15)
        .gesture(
            DragGesture(minimumDistance: 0)
                .updating($location) { value, out, _ in
                    out = value.location
                }
        )
        .coordinateSpace(name: "GESTURE")
        .preferredColorScheme(.dark)
        .animation(.easeInOut, value: location == .zero)
    }
    
    func itemScale(rect: CGRect, size: CGSize) -> CGFloat {
        let a = location.x - rect.midX
        let b = location.y - rect.midY
        
        let root = sqrt((a * a) + (b * b))
        let diagonalValue = sqrt((size.width * size.width) + (size.height * size.height))
        
        //MARK: For More Detail Divide Diagonal Value
        let scale = root / (diagonalValue / 2)
        let modifiedScale = location == .zero ? 1 : (1 - scale)
        //MARK: To Avoid SwiftUI Transform Warningz
        return modifiedScale > 0 ? modifiedScale : 0.001
    }
    
    
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
       ContentView()
    }
}
