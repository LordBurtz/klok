//
//  ContentView.swift
//  klok
//
//  Created by Fridolin Karger on 06.06.25.
//

import SwiftUI

typealias Styling = (accent: Color, width: CGFloat)

struct ContentView: View {
    
    @State private var currentTime = Date()
    @State private var showShakeAlert = false
    
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
    
    let styling: Styling = (accent: Color.whiteDD, width: 2)
    let backgroundColor: Color = Color.black11
    let padding: CGFloat = 70
    
    var body: some View {
        VStack {
            GeometryReader { geo in
                let len = min(geo.size.width, geo.size.height)
                
                VStack(alignment: .center) {
                    Spacer()
                        .frame(height: geo.size.height * 0.15)
                    
                    BlockKlock(hour: CGFloat(hour), minute: CGFloat(minute), second: CGFloat(second), styling: styling)
                        .frame(width: len, height: len)
                    
                    Spacer()
                        .frame(height: 30)
                    
                    SteinKlock(hour: hour, minute: minute, second: second)
                    
                    Spacer()
                }
                .frame(maxHeight: .infinity)
            }
        }
        .padding(padding)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(backgroundColor)
        .onReceive(timer) { input in
            currentTime = input
        }
        .withSecondFeedback(trigger: second)
        .withMinuteFeedback(trigger: minute)
        .withHourFeedback(trigger: hour)
        .withShakeEasterEgg(showShakeAlert: $showShakeAlert) {
            showShakeAlert = true
        }
    }
}

extension View {
    func withSecondFeedback<T : Equatable>(trigger: T) -> some View where T : Equatable {
        self
            .sensoryFeedback(
                .impact(weight: .light),
                trigger: trigger)
    }
    
    func withMinuteFeedback<T : Equatable>(trigger: T) -> some View where T : Equatable {
        self
            .sensoryFeedback(
                .impact(weight: .medium),
                trigger: trigger)
    }
    
    func withHourFeedback<T : Equatable>(trigger: T) -> some View where T : Equatable {
        self
            .sensoryFeedback(
                .impact(weight: .heavy),
                trigger: trigger)
    }
}

#Preview {
    ContentView()
}
