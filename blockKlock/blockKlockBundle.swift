//
//  blockKlockBundle.swift
//  blockKlock
//
//  Created by Fridolin Karger on 06.06.25.
//

import WidgetKit
import SwiftUI

@main
struct blockKlockBundle: WidgetBundle {
    var body: some Widget {
        blockKlock()
        blockKlockControl()
        blockKlockLiveActivity()
    }
}
