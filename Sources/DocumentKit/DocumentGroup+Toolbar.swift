//
//  DocumentGroup+Toolbar.swift
//  DocumentKit
//
//  Created by Daniel Saidi on 2023-05-26.
//  Copyright © 2023-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

@MainActor
public extension DocumentGroup {

    /// Add additional leading and trailing toolbar items to
    /// the document group.
    func additionalNavigationBarButtonItems(
        leading: [DocumentGroupToolbarItem] = [],
        trailing: [DocumentGroupToolbarItem] = []
    ) -> DocumentGroup {
        let leading = leading.map { $0.barButtonItem }
        let trailing = trailing.map { $0.barButtonItem }
        return tryCustomizeDocumentBrowser {
            $0.additionalLeadingNavigationBarButtonItems = leading
            $0.additionalTrailingNavigationBarButtonItems = trailing
        }
    }
}
