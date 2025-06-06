//
//  blockKlockLiveActivity.swift
//  blockKlock
//
//  Created by Fridolin Karger on 06.06.25.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct blockKlockAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct blockKlockLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: blockKlockAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension blockKlockAttributes {
    fileprivate static var preview: blockKlockAttributes {
        blockKlockAttributes(name: "World")
    }
}

extension blockKlockAttributes.ContentState {
    fileprivate static var smiley: blockKlockAttributes.ContentState {
        blockKlockAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: blockKlockAttributes.ContentState {
         blockKlockAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: blockKlockAttributes.preview) {
   blockKlockLiveActivity()
} contentStates: {
    blockKlockAttributes.ContentState.smiley
    blockKlockAttributes.ContentState.starEyes
}
