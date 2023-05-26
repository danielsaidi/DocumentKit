//
//  DocumentGroupPresenter.swift
//  DocumentKit
//
//  Created by Daniel Saidi on 2023-05-26.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This protocol can be implemented by any type that should be
 able to present and dismiss views from a `DocumentGroup`.
 */
public protocol DocumentGroupPresenter: DocumentGroupInspector {}

public extension DocumentGroupPresenter {

    /**
     Dismiss the currently opened document, if any.
     */
    func dismissCurrentDocument(
        completion: @escaping () -> Void = {}
    ) {
        rootViewController?.dismiss(
            animated: true,
            completion: completion
        )
    }
}

/**
 This enum defines errors that can be thrown when handling a
 ``DocumentGroupPresenter``.
 */
public enum DocumentGroupPresenterError: Error, Equatable {

    /// There was no requires parent window.
    case noParentWindow
}
