//
//  Home.swift
//  Grid Magnification Effect
//
//  Created by Антон Кулик on 28.08.2022.
//

import SwiftUI

struct Home: View {
    var body: some View {
        GeometryReader{ proxy in
            let size = proxy.size
            //MARK: To Fit Into Whole View
            //Calculating Item Count with the help of Height & Width
            //In a Row We Have 10 Items
            let width = (size.width / 10)
            let itemCount = Int((size.height / width).rounded()) * 10
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 0), count: 10), spacing: 0) {
                ForEach(0..<itemCount,id:\.self) {_ in
                    GeometryReader{innerProxy in
                       RoundedRectangle(cornerRadius: 4)
                            .fill(.orange)
                    }
                    .padding(5)
                    .frame(height: width)
                    
                }
            }
        }
        .padding(15)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
       ContentView()
    }
}
