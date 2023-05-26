//
//  DocumentGroup+Onboarding.swift
//  DocumentKit
//
//  Created by Daniel Saidi on 2023-05-26.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension DocumentGroup {

    func onboardingSheet<Content: DocumentGroupModal>(
        id: String? = nil,
        store: UserDefaults? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) -> DocumentGroup {
        onboardingModal(
            id: id,
            store: store,
            presentation: { try $0.presentAsDocumentGroupSheet() },
            content: content
        )
    }

    func onboardingFullScreenCover<Content: DocumentGroupModal>(
        id: String? = nil,
        store: UserDefaults? = nil,
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
        presentation: (Content) throws -> Void,
        @ViewBuilder content: @escaping () -> Content
    ) -> DocumentGroup {
        let store = store ?? .standard
        // store.resetDocumentGroupOnboardingState(for: id)
        if store.documentGroupOnboardingState(for: id) { return self }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
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
