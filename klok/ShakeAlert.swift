//
//  ShakeAlert.swift
//  klok
//
//  Created by Fridolin Karger on 06.06.25.
//

import SwiftUI

extension View {
    func withShakeEasterEgg(showShakeAlert: Binding<Bool>, triggering: @escaping () -> Void) -> some View {
        self
            .background(
                ShakeDetector(onShake: triggering)
            )
            .alert("| Klok |", isPresented: showShakeAlert) {
                Button("Nicht ok") { }
            } message: {
                Text(Constantins.lePoem)
                    .multilineTextAlignment(.trailing)
            }
    }
}
