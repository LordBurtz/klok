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
            
            let contentHeight = max(0, geoHeight * percentage)
            content()
                .frame(maxWidth: .infinity, maxHeight: contentHeight)
                .position(x: geoWidth / 2, y: geoHeight - contentHeight / 2)

        }
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
//            let percentage: CGFloat = 59 / 60
            
            Rectangle()
                .foregroundStyle(style.accent)
                .frame(maxWidth: style.width, maxHeight: .infinity)
                .position(x: geoWidth * percentage + 1, y: geoHeight / 2 - style.width )
            
            let contentWidth = max(0, geoWidth * percentage)
            content()
                .frame(maxWidth: contentWidth, maxHeight: .infinity)
                .position(x: contentWidth / 2, y: geoHeight / 2)

        }
    }
}

extension View {
    func overlayText(num: Int) -> some View {
        Text(String(num))
            .font(.custom("Courier", size: 32))
            .foregroundStyle(Color.white)
    }
    
    func withVerticalNumberOverlay(num: Int, _ x: CGFloat = 0, _ y: CGFloat = 0) -> some View {
        self
            .overlay(alignment: .centerLastTextBaseline) {
                overlayText(num: num)
                //                    .padding(.bottom, )
                    .border(Color.red)
                    .position(x: 1, y: 0)
                //                    .padding(.bottom, -50)
            }
            .background(Color.red.opacity(0.3))
    }
    
    func withHorizontalNumberOverlay(num: Int) -> some View {
        self
            .overlay {
                overlayText(num: num)
                    .padding(.leading, -16)
                    .frame(width: 100, height: 100)
            }
    }
}

#Preview {
    ContentView()
}
