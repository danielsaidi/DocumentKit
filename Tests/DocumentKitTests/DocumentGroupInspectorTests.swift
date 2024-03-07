//
//  DocumentGroupInspectorTests.swift
//  DocumentKit
//
//  Created by Daniel Saidi on 2023-05-26.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import DocumentKit
import XCTest

final class DocumentGroupInspectorTests: XCTestCase {

    private let inspector = TestInspector()

    func testRootViewControllerIsPublic() {

        XCTAssertNil(inspector.rootViewController)
    }
}

private class TestInspector: DocumentGroupInspector {}
