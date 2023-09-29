//
//  DocumentGroup+Customizations.swift
//  DocumentKit
//
//  Created by Daniel Saidi on 2023-05-26.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension DocumentGroup {

    typealias DocumentGroupCustomization = (UIDocumentBrowserViewController) -> Void

    /**
     Try customizing the underlying document group browser.
     */
    func tryCustomizeBrowser(
        delay: TimeInterval = UserDefaults.standardDelay,
        _ action: @escaping DocumentGroupCustomization,
        tryAgain: Bool = true
    ) -> DocumentGroup {
        if let group = documentBrowser {
            action(group)
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                _ = tryCustomizeBrowser(action, tryAgain: false)
            }
        }
        return self
    }
}
