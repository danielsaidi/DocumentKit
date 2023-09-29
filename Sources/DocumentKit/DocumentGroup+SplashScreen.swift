//
//  DocumentGroup+SplashScreen.swift
//  WriterWriter
//
//  Created by Christopher Charles Cavnor on 9/24/23.
//

import SwiftUI

public extension DocumentGroup {

    /**
     Present an  splash screen document sheet when the application starts.

     By default, the  splash screen will  be presented every time the app
     launches, after which you can use the `UserDefaults` extensions
     to handle the state of the  splash screen. You can use different `id`s to
     present different  splash screens.

     - Parameters:
     - id: The  splash screen ID, by default `nil`.
     - store: The persistency store, by default `.standard`.
     - delay: The delay before presenting the splash screen, by default `0.5`.
     - dismiss: The delay before dismissing  the  splash screen, by default `1` second more than delay.
     - content: The  splash screen content.
     */
    func splashScreenSheet<Contents: DocumentGroupModal>(
        id: String? = nil,
        store: UserDefaults? = nil,
        delay: TimeInterval? = UserDefaults.standardDelay,
        dismiss: TimeInterval? = UserDefaults.standardDelay + 1,
        @ViewBuilder content: @escaping () -> Contents
    ) -> DocumentGroup {
        splashScreenModal(
            id: id,
            store: store,
            delay: delay,
            dismiss: dismiss,
            presentation: .pageSheet,
            content: content
        )
    }

    /**
     Present a splash screen modal when the application starts.

     By default, the  splash screen will  be presented every time the app
     launches, after which you can use the `UserDefaults` extensions
     to handle the state of the  splash screen. You can use different `id`s to
     present different  splash screens.

     - Parameters:
     - id: The  splash screen ID, by default `nil`.
     - store: The persistency store, by default `.standard`.
     - delay: The delay before presenting the splash screen, by default `0.5`.
     - dismiss: The delay before dismissing  the  splash screen, by default `1` second more than delay.
     - content: The  splash screen content.
     */
    func splashScreenFullScreenCover<Contents: DocumentGroupModal>(
        id: String? = nil,
        store: UserDefaults? = nil,
        delay: TimeInterval? = UserDefaults.standardDelay,
        dismiss: TimeInterval? = UserDefaults.standardDelay + 1,
        @ViewBuilder content: @escaping () -> Contents
    ) -> DocumentGroup {
        splashScreenModal(
            id: id,
            store: store,
            delay: delay,
            dismiss: dismiss,
            presentation: .fullScreen,
            content: content
        )
    }
}

private extension DocumentGroup {

    func splashScreenModal<Contents: DocumentGroupModal>(
        id: String? = nil,
        store: UserDefaults? = nil,
        delay: TimeInterval? = UserDefaults.standardDelay,
        dismiss: TimeInterval? = UserDefaults.standardDelay + 1,
        presentation: UIModalPresentationStyle,
        @ViewBuilder content: @escaping () -> Contents
    ) -> DocumentGroup {
        let store = store ?? .standard
        // ensure that delay is never set to 0 else app will crash
        let delay = delay ?? delay == 0 ? UserDefaults.standardDelay : delay!
        // ensure that dismiss is greater than delay and lasts for at least 1 seconds (constitutes viewing time)
        let dismiss = (dismiss ?? dismiss)! <= delay ? delay + 1 : dismiss!

        // show the splash screen
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            do {
                try content().presentAsDocumentGroupModal(presentation)
                store.setDocumentGroupSplashScreenState(to: true, for: id)
            } catch {
                // treating the splash screen as mission critical
                fatalError("*** Splash screen failed to execute: \(error) ***")
            }
        }
        
        // remove spash screen after delay
        DispatchQueue.main.asyncAfter(deadline: .now() + dismiss) {
            dismissCurrentDocument()
        }
        return self
    }
}
