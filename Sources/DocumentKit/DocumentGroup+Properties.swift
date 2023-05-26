//
//  DocumentGroup+Properties.swift
//  DocumentKit
//
//  Created by Daniel Saidi on 2023-05-26.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension DocumentGroup {

    /**
     Whether or not to allow document creation.

     > Warning: Using this with a `true` value together with
     `additionalNavigationBarButtonItems` will cause the add
     button to disappear.
     */
    func allowsDocumentCreation(_ value: Bool) -> DocumentGroup {
        tryCustomizeBrowser { $0.allowsDocumentCreation = value }
    }

    /**
     Whether or not to allow picking multiple items.
     */
    func allowsPickingMultipleItems(_ value: Bool) -> DocumentGroup {
        tryCustomizeBrowser { $0.allowsPickingMultipleItems = value }
    }

    /**
     Whether or not to show file extensions in the browser.
     */
    func showFileExtensions(_ value: Bool) -> DocumentGroup {
        tryCustomizeBrowser { $0.shouldShowFileExtensions = value }
    }
}
