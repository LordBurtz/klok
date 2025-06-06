//
//  Kloks.swift
//  klok
//
//  Created by Fridolin Karger on 06.06.25.
//

import SwiftUI

typealias Styling = (accent: Color, width: CGFloat)

struct BlockKlock: View {
    let hour: CGFloat
    let minute: CGFloat
    let second: CGFloat
    let styling: Styling
    
    private var hour12: CGFloat {
        hour.truncatingRemainder(dividingBy: 12) == 0 ? 12 : hour.truncatingRemainder(dividingBy: 12)
    }
    
    var body: some View {
        Vertiklok(style: styling, percentage: (hour12 + 1) / 13) {
            Horiklok(style: styling, percentage: (minute + 1) / 61) {
                Vertiklok(style: styling, percentage: (second + 1) / 61) {
                    
                }
            }
        }
        .border(styling.accent, width: styling.width)
    }
}

struct Vertiklok<V: View>: View {
    let style: Styling
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

struct KlotzKlokWrapper: View {
    @State private var currentTime = Date()
    
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    private var hour: Int {
        Calendar.current.component(.hour, from: currentTime)
    }

    private var minute: Int {
        Calendar.current.component(.minute, from: currentTime)
    }

    private var second: Int {
        Calendar.current.component(.second, from: currentTime)
    }
    
    let styling: Styling = (accent: Color.white, width: 2)
    
    var body: some View {
        BlockKlock(
            hour: CGFloat(3), minute: CGFloat(40), second: CGFloat(30), styling: (Color.black, 2))
        .background(Color.black)
        .onReceive(timer) { input in
            currentTime = input
        }
        .id(currentTime)
    }
}

#Preview {
    VStack {
        KlotzKlokWrapper()
            .frame(width: 300, height: 300)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.black)
}
