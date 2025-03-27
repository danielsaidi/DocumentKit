//
//  DocumentGroupToolbarItem.swift
//  DocumentKit
//
//  Created by Daniel Saidi on 2023-05-26.
//  Copyright © 2023-2025 Daniel Saidi. All rights reserved.
//

import UIKit

/// This extension marks `UIBarButtonItem` as selected for a
/// popover anchoring. Note that only one single item can be
/// selected concurrently.
extension UIBarButtonItem {
    static var selected = false
    static var selectedItem: UIBarButtonItem?
}

/// This struct can be used to add custom toolbar items to a
/// ``SwiftUI/DocumentGroup``.
///
/// You can add leading and trailing items to a group, using
/// the ``SwiftUI/DocumentGroup/additionalNavigationBarButtonItems(leading:trailing:)``
/// view modifier.
///
/// You can use the `customization` parameter to customize a
/// bar button item's native view. This can be used to apply
/// additional properties, like accessibility.
@MainActor
public class DocumentGroupToolbarItem {
    
    private let icon: UIImage?
    private let action: () -> Void
    private let customization: (UIBarButtonItem) -> Void

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
    func callAction(_ sender: UIBarButtonItem) {
        UIBarButtonItem.selected = true
        UIBarButtonItem.selectedItem = sender
        action()
    }
}
