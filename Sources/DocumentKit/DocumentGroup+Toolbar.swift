//
//  DocumentGroup+Toolbar.swift
//  DocumentKit
//
//  Created by Daniel Saidi on 2023-05-26.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension DocumentGroup {

    /**
     Add additional trailing bar items to the document group.
     */
    func additionalNavigationBarButtonItems(
        leading: [DocumentGroupToolbarItem] = [],
        trailing: [DocumentGroupToolbarItem] = []
    ) -> DocumentGroup {
        let leading = leading.map { $0.barButtonItem }
        let trailing = trailing.map { $0.barButtonItem }
        return tryCustomizeBrowser {
            $0.additionalLeadingNavigationBarButtonItems = leading
            $0.additionalTrailingNavigationBarButtonItems = trailing
        }
    }
}
