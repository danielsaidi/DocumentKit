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

    var body: some Scene {
        DocumentGroup(newDocument: DemoDocument()) { file in
            ContentView(document: file.$document)
        }
        // .allowsDocumentCreation(true)
        // .allowsPickingMultipleItems(true)
        // .showFileExtensions(true)
        .additionalNavigationBarButtonItems(
            leading: [.onboarding],
            trailing: [.settings]
        )
        .onboardingSheet {
            DemoOnboardingScreen()
        }
    }
}

private extension DocumentGroupToolbarItem {

    static let onboarding = DocumentGroupToolbarItem(icon: .onboarding) {
        try? DemoOnboardingScreen()
            .presentAsDocumentGroupFullScreenCover()
    }

    static let settings = DocumentGroupToolbarItem(icon: .settings) {
        try? DemoSettingsScreen()
            .presentAsDocumentGroupSheet()
    }
}

private extension UIImage {

    static let onboarding = UIImage(systemName: "lightbulb")
    static let settings = UIImage(systemName: "gearshape")
}
