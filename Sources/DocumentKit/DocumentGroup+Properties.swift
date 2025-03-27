//
//  DocumentGroup+Properties.swift
//  DocumentKit
//
//  Created by Daniel Saidi on 2023-05-26.
//  Copyright © 2023-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

@MainActor
public extension DocumentGroup {

    /// Set if the document group allows document creation.
    ///
    /// > Warning: If you set this to `true` when also using
    /// `additionalNavigationBarButtonItems(...)` the button
    /// will be removed.
    func allowsDocumentCreation(_ value: Bool) -> DocumentGroup {
        tryCustomizeDocumentBrowser {
            $0.allowsDocumentCreation = value
        }
    }

    /// Set if the document group can pick multiple items.
    func allowsPickingMultipleItems(_ value: Bool) -> DocumentGroup {
        tryCustomizeDocumentBrowser {
            $0.allowsPickingMultipleItems = value
        }
    }

    /// Set if the document group should show file types.
    func showFileExtensions(_ value: Bool) -> DocumentGroup {
        tryCustomizeDocumentBrowser {
            $0.shouldShowFileExtensions = value
        }
    }
}
