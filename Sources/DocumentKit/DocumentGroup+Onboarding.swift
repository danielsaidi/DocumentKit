//
//  DocumentGroup+Onboarding.swift
//  DocumentKit
//
//  Created by Daniel Saidi on 2023-05-26.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension DocumentGroup {

    /**
     Present an onboarding sheet when the application starts.

     The onboarding will only be presented once, after which
     you can use the `UserDefaults` extensions to handle the
     state of the onboarding. You can use different `id`s to
     present different onboardings.

     - Parameters:
       - id: The onboarding ID, by default `nil`.
       - store: The persistency store, by default `.standard`.
       - delay: The delay before presenting the onboarding, by default `0.5`.
       - content: The onboarding content.
     */
    func onboardingSheet<Contents: DocumentGroupModal>(
        id: String? = nil,
        store: UserDefaults? = nil,
        delay: TimeInterval? = 0.5,
        @ViewBuilder content: @escaping () -> Contents
    ) -> DocumentGroup {
        onboardingModal(
            id: id,
            store: store,
            delay: delay,
            presentation: { try $0.presentAsDocumentGroupSheet() },
            content: content
        )
    }

    /**
     Present an onboarding modal when the application starts.

     The onboarding will only be presented once, after which
     you can use the `UserDefaults` extensions to handle the
     state of the onboarding. You can use different `id`s to
     present different onboardings.

     - Parameters:
       - id: The onboarding ID, by default `nil`.
       - store: The persistency store, by default `.standard`.
       - delay: The delay before presenting the onboarding, by default `0.5`.
       - content: The onboarding content.       
     */
    func onboardingFullScreenCover<Contents: DocumentGroupModal>(
        id: String? = nil,
        store: UserDefaults? = nil,
        delay: TimeInterval? = 0.5,
        @ViewBuilder content: @escaping () -> Contents
    ) -> DocumentGroup {
        onboardingModal(
            id: id,
            store: store,
            delay: delay,
            presentation: { try $0.presentAsDocumentGroupFullScreenCover() },
            content: content
        )
    }
}

private extension DocumentGroup {

    private func onboardingModal<Contents: DocumentGroupModal>(
        id: String? = nil,
        store: UserDefaults? = nil,
        delay: TimeInterval? = nil,
        presentation: (Content) throws -> Void,
        @ViewBuilder content: @escaping () -> Contents
    ) -> DocumentGroup {
        let store = store ?? .standard
        // ensure that delay is never set to 0 else app will crash
        let delay = delay ?? delay == 0 ? 0.5 : delay!

        // store.resetDocumentGroupOnboardingState(for: id)
        if store.documentGroupOnboardingState(for: id) { return self }
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            do {
                try content().presentAsDocumentGroupFullScreenCover()
                store.setDocumentGroupOnboardingState(to: true, for: id)
            } catch {
                // treat as mission critical
                fatalError("*** Onboarding screen error: \(error) ***")
            }
        }
        return self
    }
}
