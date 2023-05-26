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
    func onboardingSheet<Content: DocumentGroupModal>(
        id: String? = nil,
        store: UserDefaults? = nil,
        delay: TimeInterval? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) -> DocumentGroup {
        onboardingModal(
            id: id,
            store: store,
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
    func onboardingFullScreenCover<Content: DocumentGroupModal>(
        id: String? = nil,
        store: UserDefaults? = nil,
        delay: TimeInterval? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) -> DocumentGroup {
        onboardingModal(
            id: id,
            store: store,
            presentation: { try $0.presentAsDocumentGroupFullScreenCover() },
            content: content
        )
    }
}

private extension DocumentGroup {

    func onboardingModal<Content: DocumentGroupModal>(
        id: String? = nil,
        store: UserDefaults? = nil,
        delay: TimeInterval? = nil,
        presentation: (Content) throws -> Void,
        @ViewBuilder content: @escaping () -> Content
    ) -> DocumentGroup {
        let store = store ?? .standard
        let delay = delay ?? 0.5
        // store.resetDocumentGroupOnboardingState(for: id)
        if store.documentGroupOnboardingState(for: id) { return self }
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            do {
                try content().presentAsDocumentGroupFullScreenCover()
                store.setDocumentGroupOnboardingState(to: true, for: id)
            } catch {
                print("*** ERROR: \(error) ***")
            }
        }
        return self
    }
}
