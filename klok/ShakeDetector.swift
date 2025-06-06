//
//  ShakeDetector.swift
//  klok
//
//  Created by Fridolin Karger on 06.06.25.
//

import SwiftUI
import UIKit

// UIViewController that can detect shake motions
class ShakeDetectingViewController: UIViewController {
    var onShake: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Make this view controller the first responder to receive motion events
        becomeFirstResponder()
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    // This method is called when the device detects the end of a shake motion
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            onShake?()
        }
    }
}

// SwiftUI wrapper for the shake-detecting view controller
struct ShakeDetector: UIViewControllerRepresentable {
    let onShake: () -> Void
    
    func makeUIViewController(context: Context) -> ShakeDetectingViewController {
        let controller = ShakeDetectingViewController()
        controller.onShake = onShake
        return controller
    }
    
    func updateUIViewController(_ uiViewController: ShakeDetectingViewController, context: Context) {
        uiViewController.onShake = onShake
    }
} 