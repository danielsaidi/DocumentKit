//
//  DocumentGroup+Customizations.swift
//  DocumentKit
//
//  Created by Daniel Saidi on 2023-05-26.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension DocumentGroup {

    typealias DocumentGroupCustomization = (UIDocumentBrowserViewController) -> Void

    /// Try customizing the underlying document browser.
    func tryCustomizeBrowser(
        delay: TimeInterval = .defaultDocumentModalDelay,
        _ action: @escaping DocumentGroupCustomization
    ) -> DocumentGroup {
        if let group = documentBrowser {
            action(group)
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                _ = tryCustomizeBrowser(action)
            }
        }
        return self
    }
}
