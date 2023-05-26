//
//  DocumentGroupToolbarItem.swift
//  DocumentKit
//
//  Created by Daniel Saidi on 2023-05-26.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import UIKit

/**
 This struct can be used to add custom toolbar items to your
 `DocumentGroup`.

 You can add leading and trailing items to a `DocumentGroup`,
 with the `additionalNavigationBarButtonItems` modifier.
 */
public class DocumentGroupToolbarItem {

    /// Create a document group toolbar item.
    public init(
        icon: UIImage?,
        action: @escaping () -> Void,
        customization: @escaping (UIBarButtonItem) -> Void = { _ in }
    ) {
        self.icon = icon
        self.action = action
        self.customization = customization
    }

    private let icon: UIImage?
    private let action: () -> Void
    private let customization: (UIBarButtonItem) -> Void

    var barButtonItem: UIBarButtonItem {
        let item = UIBarButtonItem(
            image: icon,
            style: .plain,
            target: self,
            action: #selector(callAction)
        )
        customization(item)
        return item
    }

    @objc
    func callAction() {
        action()
    }
}
