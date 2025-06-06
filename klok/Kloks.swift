//
//  Kloks.swift
//  klok
//
//  Created by Fridolin Karger on 06.06.25.
//

import SwiftUI

struct Vertiklok<V: View>: View {
    let style: Styling
    let value: Int
    let percentage: CGFloat
    
    @ViewBuilder var content: () -> V
    
    var body: some View {
        GeometryReader { geo in
            let geoWidth = geo.size.width
            let geoHeight = geo.size.height
            
            Rectangle()
                .foregroundStyle(style.accent)
                .frame(maxWidth: .infinity, maxHeight: style.width)
                .position(x: geoWidth / 2, y: geoHeight - geoHeight * percentage - style.width / 2)
            
            let contentHeight = max(0, geoHeight * percentage - style.width / 2)
            content()
                .frame(maxWidth: .infinity, maxHeight: contentHeight)
                .position(x: geoWidth / 2, y: geoHeight - contentHeight / 2)

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct Horiklok<V: View>: View {
    let style: Styling
    let value: Int
    let percentage: CGFloat
    
    @ViewBuilder var content: () -> V
    
    var body: some View {
        GeometryReader { geo in
            let geoWidth = geo.size.width
            let geoHeight = geo.size.height
            
            Rectangle()
                .foregroundStyle(style.accent)
                .frame(maxWidth: style.width, maxHeight: .infinity)
                .position(x: geoWidth * percentage + 1, y: geoHeight / 2 - style.width )
            
            let contentWidth = max(0, geoWidth * percentage)
            content()
                .frame(maxWidth: contentWidth, maxHeight: .infinity)
                .position(x: contentWidth / 2, y: geoHeight / 2)

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    ContentView()
}
