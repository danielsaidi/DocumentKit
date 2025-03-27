//
//  DocumentGroupInspector.swift
//  DocumentKit
//
//  Created by Daniel Saidi on 2023-05-26.
//  Copyright © 2023-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This protocol can be implemented by any type that should
/// be able to inspect the current ``SwiftUI/DocumentGroup``.
///
/// The protocol is implemented by ``SwiftUI/DocumentGroup``.
public protocol DocumentGroupInspector {}

extension DocumentGroup: DocumentGroupInspector {}

@MainActor
public extension DocumentGroupInspector {

    /// Get the current `UIDocumentBrowserViewController`.
    var documentBrowser: UIDocumentBrowserViewController? {
        rootViewController as? UIDocumentBrowserViewController
    }

    /// Get the current `UIViewController`.
    var rootViewController: UIViewController? {
        keyWindow?.rootViewController
    }

    /// Dismiss the currently opened document, if any.
    func dismissCurrentDocument(
        completion: @escaping () -> Void = {}
    ) {
        rootViewController?.dismiss(
            animated: true,
            completion: completion
        )
    }
}

@MainActor
private extension DocumentGroupInspector {

    var keyWindow: UIWindow? {
        UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .filter { $0.isKeyWindow }
            .first
    }
}
