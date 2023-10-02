//
//  DemoApp.swift
//  Demo
//
//  Created by Daniel Saidi on 2023-05-26.
//

import SwiftUI
import DocumentKit

@main
struct DemoApp: App {
    init() {
        UserDefaults().resetDocumentGroupOnboardingState()
    }

    var body: some Scene {
        DocumentGroup(newDocument: DemoDocument()) { file in
            ContentView(document: file.$document)
        }
        // .allowsDocumentCreation(true)
        // .allowsPickingMultipleItems(true)
        // .showFileExtensions(true)
        .additionalNavigationBarButtonItems(
            leading: [.onboarding, .popover],
            trailing: [.settings]
        )
        .splashScreenSheet(delay: 0.5, dismiss: 3) {
            DemoSplashScreenSheet()
        }
        .onboardingSheet(delay: 4) {
            DemoOnboardingScreen()
        }
    }
}

private extension DocumentGroupToolbarItem {

    // present the Onboarding view as a full sheet cover
    static let onboarding = DocumentGroupToolbarItem(icon: .onboarding) {
        try? DemoOnboardingScreen()
            .presentAsDocumentGroupFullScreenCover()
    }

    // present the settings view as a sheet
    static let settings = DocumentGroupToolbarItem(icon: .settings) {
        try? DemoSettingsScreen()
            .presentAsDocumentGroupSheet()
    }

    // present story details as a popOver below the .storyDetails icon
    static let popover = DocumentGroupToolbarItem(icon: .popover) {
        try? DemoPopoverScreen()
            .presentAsDocumentGroupPopover()
    }
}

private extension UIImage {
    static let popover = UIImage(systemName: "book")
    static let onboarding = UIImage(systemName: "lightbulb")
    static let settings = UIImage(systemName: "gearshape")
}
