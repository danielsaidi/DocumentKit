//
//  DocumentGroup+Onboarding.swift
//  DocumentKit
//
//  Created by Daniel Saidi on 2023-05-26.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

@MainActor
public extension DocumentGroup {

    /// Present an onboarding modal when the app launches.
    ///
    /// The onboarding will only be presented once, and will
    /// never be presented again for the provided `id`.
    ///
    /// You can use ``Foundation/UserDefaults``'s onboarding
    /// extensions to get and modify the onboarding state of
    /// a certain onboarding.
    ///
    /// - Parameters:
    ///   - id: The onboarding ID.
    ///   - type: The type of modal to use, by default a ``DocumentGroupModalType/sheet``.
    ///   - store: The persistency store, by default `.standard`.
    ///   - delay: The delay before presenting the onboarding.
    ///   - content: The onboarding content.
    func onboardingModal<Contents: DocumentGroupModal>(
        id: String?,
        type: DocumentGroupModalType = .sheet,
        store: UserDefaults? = nil,
        delay: TimeInterval? = .defaultDocumentModalDelay,
        dismissAfter: TimeInterval? = nil,
        @ViewBuilder content: @escaping () -> Contents
    ) -> DocumentGroup {
        let store = store ?? .standard
        if let id {
            if store.documentPresentationState(for: id) { return self }
            store.setDocumentPresentationState(to: true, for: id)
        }

        return modal(
            type: type,
            delay: delay,
            dismissAfter: dismissAfter,
            content: content()
        )
    }

    /// Present a splash screen when the app launches.
    ///
    /// The splash screen is only be presented if a provided
    /// condition is true.
    ///
    /// - Parameters:
    ///   - if: The splash screen condition, by default `true`.
    ///   - type: The type of modal to use, by default a ``DocumentGroupModalType/sheet``.
    ///   - store: The persistency store, by default `.standard`.
    ///   - delay: The delay before presenting the onboarding.
    ///   - content: The onboarding content.
    func splashScreen<Contents: DocumentGroupModal>(
        if condition: Bool = true,
        type: DocumentGroupModalType = .sheet,
        store: UserDefaults? = nil,
        delay: TimeInterval? = .defaultDocumentModalDelay,
        dismissAfter: TimeInterval? = nil,
        @ViewBuilder content: @escaping () -> Contents
    ) -> DocumentGroup {
        guard condition else { return self }
        return modal(
            type: type,
            delay: delay,
            dismissAfter: dismissAfter,
            content: content()
        )
    }

    /// Present a modal view.
    ///
    /// - Parameters:
    ///   - type: The type of modal to use.
    ///   - delay: The delay before presenting the onboarding.
    ///   - dismissAfter: The delay before dismissing the view.
    ///   - content: The onboarding content.
    func modal<Contents: DocumentGroupModal>(
        type: DocumentGroupModalType,
        delay: TimeInterval? = .defaultDocumentModalDelay,
        dismissAfter: TimeInterval? = nil,
        content: Contents
    ) -> DocumentGroup {
        let defaultDelay = TimeInterval.defaultDocumentModalDelay
        let delay = max(0.1, delay ?? defaultDelay)

        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            do {
                try content.presentAsDocumentGroupModal(type)
            } catch {
                // treat as mission critical
                fatalError("*** Onboarding screen error: \(error) ***")
            }
        }
        
        if let dismiss = dismissAfter {
            DispatchQueue.main.asyncAfter(deadline: .now() + delay + dismiss) {
                dismissCurrentDocument()
            }
        }
        
        return self
    }
}

extension DocumentGroup: @unchecked Sendable {}
