//
//  DemoApp.swift
//  Demo
//
//  Created by Daniel Saidi on 2023-05-26.
//

import SwiftUI

@main
struct DemoApp: App {

    var body: some Scene {
        DocumentGroup(newDocument: DemoDocument()) { file in
            ContentView(document: file.$document)
        }.onboardingSheet {
            DemoOnboardingScreen()
        }
    }
}
