//
//  DocumentGroup+Customizations.swift
//  DocumentKit
//
//  Created by Daniel Saidi on 2023-05-26.
//  Copyright © 2023-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

@MainActor
public extension DocumentGroup {

    /// This typealias represents a document browser action.
    typealias DocumentGroupCustomization = (UIDocumentBrowserViewController) -> Void

    /// Try customizing the underlying document browser.
    ///
    /// This is a best-effort attempt, that is determined by
    /// how SwiftUI creates the document browser. The action
    /// will be applied if a browser is available, but if it
    /// isn't, it will wait for the provided delay, then try
    /// again. This is repeated by extending the delay every
    /// time it's used, and aborts once it becomes too large,
    /// to avoid a never-ending collection of retries.
    @discardableResult
    func tryCustomizeDocumentBrowser(
        delay: TimeInterval = .defaultDocumentModalDelay,
        _ action: @escaping DocumentGroupCustomization
    ) -> DocumentGroup {
        if let group = documentBrowser {
            action(group)
        } else if delay < 2 {
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                tryCustomizeDocumentBrowser(
                    delay: delay * 2,
                    action
                )
            }
        }
        return self
    }
}
