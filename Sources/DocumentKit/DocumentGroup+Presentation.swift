//
//  DocumentGroup+Onboarding.swift
//  DocumentKit
//
//  Created by Daniel Saidi on 2023-05-26.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension DocumentGroup {

    /**
     Present an onboarding sheet when the application starts.

     The onboarding will only be presented once, after which
     you can use `UserDefaults` to handle state for the `id`.

     - Parameters:
       - id: The onboarding ID.
       - store: The persistency store, by default `.standard`.
       - delay: The delay before presenting the onboarding, by default `.defaultDocumentModalDelay`.
       - content: The onboarding content.
     */
    func onboardingSheet<Contents: DocumentGroupModal>(
        id: String,
        store: UserDefaults? = nil,
        delay: TimeInterval? = .defaultDocumentModalDelay,
        @ViewBuilder content: @escaping () -> Contents
    ) -> DocumentGroup {
        onboardingPresentation(
            id: id,
            store: store,
            delay: delay,
            style: .pageSheet,
            content: content
        )
    }

    /**
     Present an onboarding cover when the application starts.

     The onboarding will only be presented once, after which
     you can use `UserDefaults` to handle state for the `id`.

     - Parameters:
       - id: The onboarding ID.
       - store: The persistency store, by default `.standard`.
       - delay: The delay before presenting the onboarding, by default `.defaultDocumentModalDelay`.
       - content: The onboarding content.       
     */
    func onboardingFullScreenCover<Contents: DocumentGroupModal>(
        id: String,
        store: UserDefaults? = nil,
        delay: TimeInterval? = .defaultDocumentModalDelay,
        @ViewBuilder content: @escaping () -> Contents
    ) -> DocumentGroup {
        onboardingPresentation(
            id: id,
            store: store,
            delay: delay,
            style: .fullScreen,
            content: content
        )
    }
    
    /**
     Present a splash sheet when the application starts.

     The splash screen will be presented every time your app
     starts, unless you pass in an `id`.

     - Parameters:
       - id: The splash screen ID, by default `nil`.
       - store: The persistency store, by default `.standard`.
       - delay: The delay before presenting the splash screen, by default `.defaultDocumentModalDelay`.
       - dismiss: The delay before dismissing the splash screen, by default `1`.
       - content: The splash screen content.
     */
    func splashScreenSheet<Contents: DocumentGroupModal>(
        id: String? = nil,
        store: UserDefaults? = nil,
        delay: TimeInterval? = .defaultDocumentModalDelay,
        dismissAfter: TimeInterval? = .defaultDocumentModalDelay + 1,
        @ViewBuilder content: @escaping () -> Contents
    ) -> DocumentGroup {
        presentation(
            delay: delay,
            dismissAfter: dismissAfter,
            style: .pageSheet,
            content: content
        )
    }

    /**
     Present a splash cover when the application starts.

     The splash screen will be presented every time your app
     starts, unless you pass in an `id`.

     - Parameters:
       - id: The splash screen ID, by default `nil`.
       - store: The persistency store, by default `.standard`.
       - delay: The delay before presenting the splash screen, by default `.defaultDocumentModalDelay`.
       - dismiss: The delay before dismissing the splash screen, by default `1`.
       - content: The splash screen content.
     */
    func splashScreenFullScreenCover<Contents: DocumentGroupModal>(
        id: String? = nil,
        store: UserDefaults? = nil,
        delay: TimeInterval? = .defaultDocumentModalDelay,
        dismissAfter: TimeInterval? = .defaultDocumentModalDelay + 1,
        @ViewBuilder content: @escaping () -> Contents
    ) -> DocumentGroup {
        presentation(
            delay: delay,
            dismissAfter: dismissAfter,
            style: .fullScreen,
            content: content
        )
    }
}

private extension DocumentGroup {
    
    private func onboardingPresentation<Contents: DocumentGroupModal>(
        id: String?,
        store: UserDefaults? = nil,
        delay: TimeInterval? = .defaultDocumentModalDelay,
        dismissAfter: TimeInterval? = nil,
        style: UIModalPresentationStyle,
        @ViewBuilder content: @escaping () -> Contents
    ) -> DocumentGroup {
        let store = store ?? .standard
        if let id {
            if store.documentPresentationState(for: id) { return self }
            store.setDocumentPresentationState(to: true, for: id)
        }
        
        return presentation(
            delay: delay,
            dismissAfter: dismissAfter,
            style: style,
            content: content
        )
    }
    
    private func presentation<Contents: DocumentGroupModal>(
        delay: TimeInterval? = .defaultDocumentModalDelay,
        dismissAfter: TimeInterval? = nil,
        style: UIModalPresentationStyle,
        @ViewBuilder content: @escaping () -> Contents
    ) -> DocumentGroup {
        let queue = DispatchQueue.main
        let defaultDelay = TimeInterval.defaultDocumentModalDelay
        let delay = max(0.1, delay ?? defaultDelay)
        
        queue.asyncAfter(deadline: .now() + delay) {
            do {
                try content().presentAsDocumentGroupModal(style)
            } catch {
                // treat as mission critical
                fatalError("*** Onboarding screen error: \(error) ***")
            }
        }
        
        if let dismiss = dismissAfter {
            queue.asyncAfter(deadline: .now() + delay + dismiss) {
                dismissCurrentDocument()
            }
        }
        
        return self
    }
}
