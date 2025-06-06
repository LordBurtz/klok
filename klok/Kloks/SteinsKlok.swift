//
//  DigiKlok.swift
//  klok
//
//  Created by Fridolin Karger on 06.06.25.
//

import SwiftUI

struct SteinKlock: View {
    let hour: Int
    let minute: Int
    let second: Int
    
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            FancyNumber(num: hour)
            FancyNumber(num: minute)
            FancyNumber(num: second)
        }
    }
}

struct FancyNumber: View {
    let num: Int
    
    var body: some View {
        HStack {
            ForEach(num.digits, id: \.self) { i in
                FancyDigit(num: String(i))
            }
        }
    }
}

struct FancyDigit: View {
    let num: String
    
    let textColor = Color.orangeFF
    let bgTextColor = Color.whiteDD
    let bgTextOpacity = 0.1
    let fontSize: CGFloat = 40
    
    var body: some View {
        ZStack {
            ForEach(0..<14) { i in
                Text(String(format: "%d", Int.random(in: 0..<10)))
                    .font(.custom("Courier", size: fontSize + 10))
                    .foregroundStyle(bgTextColor)
                    .opacity(bgTextOpacity)
            }
            Text(num)
                .font(.custom("Courier", size: fontSize))
                .foregroundStyle(textColor)
        }
    }
}

extension CVarArg {
    var digits: [Int] { String(format: "%02d", self).compactMap({$0.wholeNumberValue}) }
}

private struct SteinsKlokWrapper: View {
    @State private var currentTime = Date()
    private let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    var body: some View {
        SteinKlock(hour: Int.random(in: 1..<25), minute: Int.random(in: 1..<61), second: Int.random(in: 1..<61))
        .frame(maxWidth: .infinity, maxHeight: .infinity,)
        .background(Color.black)
        .onReceive(timer) { input in
            currentTime = input
        }
        .id(currentTime)
    }
}

#Preview {
    SteinsKlokWrapper()
}
