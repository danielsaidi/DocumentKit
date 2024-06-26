//
//  DemoApp.swift
//  Demo
//
//  Created by Daniel Saidi on 2023-05-26.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI
import DocumentKit

@main
struct DemoApp: App {
    
    init() {
        UserDefaults().resetDocumentPresentationState(for: "onboarding")
    }

    var body: some Scene {
        DocumentGroup(newDocument: DemoDocument()) { file in
            ContentView(document: file.$document)
        }
        // .allowsDocumentCreation(true)
        // .allowsPickingMultipleItems(true)
        // .showFileExtensions(true)
        .additionalNavigationBarButtonItems(
            leading: [.onboardingItem, .popoverItem],
            trailing: [.settingsItem]
        )
        .splashScreen(delay: 0.5, dismissAfter: 3) {
            DemoSplashScreenSheet()
        }
        .onboardingModal(id: "onboarding", delay: 4) {
            DemoOnboardingScreen()
        }
    }
}

@MainActor
private extension DocumentGroupToolbarItem {

    // Present the Onboarding view as a full sheet cover
    static let onboardingItem = DocumentGroupToolbarItem(icon: .onboarding) {
        try? DemoOnboardingScreen()
            .presentAsDocumentGroupModal(.fullScreenCover)
    }

    // Present the settings view as a sheet
    static let settingsItem = DocumentGroupToolbarItem(icon: .settings) {
        try? DemoSettingsScreen()
            .presentAsDocumentGroupModal(.sheet)
    }

    // Present story details as a popOver below the .storyDetails icon
    static let popoverItem = DocumentGroupToolbarItem(icon: .popover) {
        try? DemoPopoverScreen()
            .presentAsDocumentGroupModal(.popover)
    }
}

private extension UIImage {
    
    static let popover = UIImage(systemName: "book")
    static let onboarding = UIImage(systemName: "lightbulb")
    static let settings = UIImage(systemName: "gearshape")
}
