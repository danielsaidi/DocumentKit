//
//  DocumentGroup+SplashScreen.swift
//  WriterWriter
//
//  Created by Christopher Charles Cavnor on 9/24/23.
//

import SwiftUI

public extension DocumentGroup {

    /**
     Present a splash screen sheet when the application starts.

     The  splash screen will be presented each time the app starts, but
     you can use the `UserDefaults` extensions to handle the
     state of the  splash screen. You can use different `id`s to
     present different  splash screens.

     - Parameters:
     - id: The  splash screen ID, by default `nil`.
     - store: The persistency store, by default `.standard`.
     - delay: The delay before presenting the  splash screen, by default `0.5`.
     - dismiss: The delay before dismissing  the  splash screen, by default `1`.
     - content: The  splash screen content.
     */
    func splashScreenSheet<Contents: DocumentGroupModal>(
        id: String? = nil,
        store: UserDefaults? = nil,
        delay: TimeInterval? = nil,
        dismiss: TimeInterval? = nil,
        @ViewBuilder content: @escaping () -> Contents
    ) -> DocumentGroup {
        splashScreenModal(
            id: id,
            store: store,
            delay: delay,
            dismiss: dismiss,
            presentation: { try $0.presentAsDocumentGroupSheet() },
            content: content
        )
    }

    /**
     Present an  splash screen modal when the application starts.

     The  splash screen will only be presented once, after which
     you can use the `UserDefaults` extensions to handle the
     state of the  splash screen. You can use different `id`s to
     present different  splash screens.

     - Parameters:
     - id: The  splash screen ID, by default `nil`.
     - store: The persistency store, by default `.standard`.
     - delay: The delay before presenting the splash screen, by default `0.5`.
     - dismiss: The delay before dismissing  the  splash screen, by default `1`.
     - content: The  splash screen content.
     */
    func splashFullScreenCover<Contents: DocumentGroupModal>(
        id: String? = nil,
        store: UserDefaults? = nil,
        delay: TimeInterval? = nil,
        dismiss: TimeInterval? = nil,
        @ViewBuilder content: @escaping () -> Contents
    ) -> DocumentGroup {
        splashScreenModal(
            id: id,
            store: store,
            delay: delay,
            dismiss: dismiss,
            presentation: { try $0.presentAsDocumentGroupFullScreenCover() },
            content: content
        )
    }
}

private extension DocumentGroup {

    func splashScreenModal<Contents: DocumentGroupModal>(
        id: String? = nil,
        store: UserDefaults? = nil,
        delay: TimeInterval? = nil,
        dismiss: TimeInterval? = nil,
        presentation: (Contents) throws -> Void,
        @ViewBuilder content: @escaping () -> Contents
    ) -> DocumentGroup {
        let store = store ?? .standard
        // ensure that delay is never set to 0 else app will crash
        let delay = delay ?? delay == 0 ? 0.5 : delay!
        // ensure that dismiss is greater than delay and lasts for at least 1 seconds (constitutes viewing time)
        let dismiss = (dismiss ?? dismiss)! <= delay ? delay + 1 : dismiss!

        print("delay=\(delay) and dismiss=\(dismiss)")

        // show the splash screen
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            do {
                try content().presentAsDocumentGroupFullScreenCover()
                store.setDocumentGroupSplashScreenState(to: true, for: id)
            } catch {
                // treating the splash screen as missoin critical
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
