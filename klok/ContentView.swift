//
//  ContentView.swift
//  klok
//
//  Created by Fridolin Karger on 06.06.25.
//

import SwiftUI

typealias Styling = (accent: Color, width: CGFloat)

struct ContentView: View {
    
    @State private var currentTime = Date(timeIntervalSince1970: TimeInterval(1749207618)) //Date()
//    @State private var currentTime = Date()
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    private var hour: CGFloat {
        CGFloat(Calendar.current.component(.second, from: currentTime))
    }

    private var minute: CGFloat {
        CGFloat(Calendar.current.component(.second, from: currentTime))
    }

    private var second: CGFloat {
        CGFloat(Calendar.current.component(.second, from: currentTime))
    }
    
    private var hour12: CGFloat {
        hour.truncatingRemainder(dividingBy: 12) == 0 ? 12 : hour.truncatingRemainder(dividingBy: 12)
    }
    
    let styling: Styling = (accent: Color.whiteDD, width: 2)
    
    var body: some View {
        VStack {
            GeometryReader { geo in
                let len = min(geo.size.width, geo.size.height)
                
                VStack(alignment: .center) {
                    Spacer()
                        .frame(height: geo.size.height * 0.15)
                    
                    Vertiklok(style: styling, value: Int(hour12), percentage: hour12 / 12) {
                        Horiklok(style: styling, value: Int(minute), percentage: minute / 60) {
                            Vertiklok(style: styling, value: Int(second), percentage: second / 60) {
                                
                            }
                        }
                    }
                    .frame(width: len, height: len)
                    .border(styling.accent, width: styling.width)
                    
                    Spacer()
                        .frame(height: 30)
                    
                    HStack(alignment: .center, spacing: 10) {
                        FancyNumber(num: Int(hour))
                        FancyNumber(num: Int(minute))
                        FancyNumber(num: Int(second))
                    }
                    
                    Spacer()
                }
                .frame(maxHeight: .infinity)
            }
        }
        .padding(70)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black11)
        .onReceive(timer) { input in
            currentTime = input
        }
        .sensoryFeedback(
            .impact(weight: .light),
            trigger: second)
        .sensoryFeedback(
            .impact(weight: .medium),
            trigger: minute)
        .sensoryFeedback(
            .impact(weight: .heavy),
            trigger: hour)
    }
}

#Preview {
    ContentView()
}
