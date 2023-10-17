//
//  DocumentGroupModal.swift
//  DocumentKit
//
//  Created by Daniel Saidi on 2023-05-26.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
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

    /**
     Present the view as a document group sheet.
     */
    func presentAsDocumentGroupSheet() throws

    /**
     Present the view as a document group full screen cover.
     */
    func presentAsDocumentGroupFullScreenCover() throws

    /**
     Present the view as a PopOver
     */
    func presentAsDocumentGroupPopover() throws

    /**
     Present the view as a document group modal.
     */
    func presentAsDocumentGroupModal(_ style: UIModalPresentationStyle ) throws
}

/// This internal inspector is used by the view extensions.
private class InternalInspector: DocumentGroupInspector {

    static var shared = InternalInspector()
}

public extension View {

    /**
     Present the view as a document group sheet.
     */
    func presentAsDocumentGroupSheet() throws {
        try presentAsDocumentGroupModal(.automatic)
    }

    /**
     Present the view as a document group full screen cover.
     */
    func presentAsDocumentGroupFullScreenCover() throws {
        try presentAsDocumentGroupModal(.fullScreen)
    }

    /**
     Present the view as a popover anchored to the selected UIButtonBarItem.
     */
    func presentAsDocumentGroupPopover() throws {
        try presentAsDocumentGroupModal(.popover)
    }

    /**
     Present the view as a document group modal.
     popup modals are handled specially due to IOS bug: https://github.com/expo/expo/issues/22192.
     */
    func presentAsDocumentGroupModal(_ style: UIModalPresentationStyle) throws {
        let inspector = InternalInspector.shared
        guard let parent = inspector.rootViewController else { throw DocumentGroupError.noParentWindow }
        let controller = UIHostingController(rootView: self)
        controller.modalPresentationStyle = style
        controller.isModalInPresentation = false
        let rootView = controller.view
        guard let _ = inspector.documentBrowser else {
            return
        }

        // handle popover positioning
        if let popover: UIPopoverPresentationController = controller.popoverPresentationController {
            if #available(iOS 16.0, *) {
                popover.sourceItem = UIBarButtonItem.selectedItem
            } else {
                // before iOS 16, the best we can do is show popover at origin
                popover.sourceView = rootView
                popover.sourceRect = rootView?.bounds ?? CGRect()
            }
        }

        parent.present(controller, animated: true, completion: nil)
    }
}

