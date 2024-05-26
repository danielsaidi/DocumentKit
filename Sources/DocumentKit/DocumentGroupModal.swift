//
//  DocumentGroupModal.swift
//  DocumentKit
//
//  Created by Daniel Saidi on 2023-05-26.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This protocol can be implemented by any view, that you have
 to be able to open from a document group.

 Note that these presentation functions are available to all
 SwiftUI views, since you must be able to present views with
 applied view modifiers.
 */
public protocol DocumentGroupModal: View, DocumentGroupInspector {

    /// Present the view as a document group modal.
    ///
    /// Popup modals are handled specially due to IOS bug:
    /// https://github.com/expo/expo/issues/22192.
    func presentAsDocumentGroupModal(
        _ type: DocumentGroupModalType
    ) throws
}

/// This enum defines the supported document group modals.
public enum DocumentGroupModalType {

    case sheet, fullScreenCover, popover, custom(_ style: UIModalPresentationStyle)
}

public extension DocumentGroupModalType {

    /// The native presentation style to use.
    var presentationStyle: UIModalPresentationStyle {
        switch self {
        case .sheet: .automatic
        case .fullScreenCover: .fullScreen
        case .popover: .popover
        case .custom(let style): style
        }
    }
}

/// This internal inspector is used by the view extensions.
private final class InternalInspector: DocumentGroupInspector, Sendable {

    static let shared = InternalInspector()
}

@MainActor
public extension View {

    /// Present the view as a document group modal.
    ///
    /// Popup modals are handled with some iOS 16 hacks, due
    /// to a bug: https://github.com/expo/expo/issues/22192.
    func presentAsDocumentGroupModal(
        _ type: DocumentGroupModalType
    ) throws {
        let inspector = InternalInspector.shared
        guard let parent = inspector.rootViewController else { throw DocumentGroupError.noParentWindow }
        let controller = UIHostingController(rootView: self)
        controller.modalPresentationStyle = type.presentationStyle
        controller.isModalInPresentation = false
        let rootView = controller.view
        if inspector.documentBrowser == nil { return }

        // Handle popover positioning
        if let popover: UIPopoverPresentationController = controller.popoverPresentationController {
            if #available(iOS 16.0, *) {
                popover.sourceItem = UIBarButtonItem.selectedItem
            } else {
                /// Before iOS 16, the best we can do, is to
                /// show popover at the root view origin.
                popover.sourceView = rootView
                popover.sourceRect = rootView?.bounds ?? CGRect()
            }
        }

        parent.show(controller, sender: nil)
    }
}
