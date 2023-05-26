//
//  DocumentGroupError.swift
//  DocumentKit
//
//  Created by Daniel Saidi on 2023-05-26.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This enum defines errors that can be thrown when handling a
 `DocumentGroup` with the library.
 */
public enum DocumentGroupError: Error, Equatable {

    /// There was no requires parent window.
    case noParentWindow
}
