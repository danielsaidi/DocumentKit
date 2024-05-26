//
//  DocumentGroupError.swift
//  DocumentKit
//
//  Created by Daniel Saidi on 2023-05-26.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This enum defines document group-related errors.
public enum DocumentGroupError: Error, Equatable {

    /// There was no requires parent window.
    case noParentWindow
}
