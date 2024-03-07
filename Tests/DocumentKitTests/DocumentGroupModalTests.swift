//
//  DocumentGroupModalTests.swift
//  DocumentKit
//
//  Created by Daniel Saidi on 2023-05-26.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import DocumentKit
import SwiftUI
import XCTest

final class DocumentGroupModalTests: XCTestCase {

    private let modal = TestModal()

    func testCanBeOpenedAsDocumentGroupSheet() {
        do {
            try modal.presentAsDocumentGroupSheet()
            XCTFail("This test should fail with a missing parent error")
        } catch {
            let error = error as? DocumentGroupError
            XCTAssertEqual(error, .noParentWindow)
        }
    }

    func testCanBeOpenedAsDocumentGroupFullScreenCover() {
        do {
            try modal.presentAsDocumentGroupFullScreenCover()
            XCTFail("This test should fail with a missing parent error")
        } catch {
            let error = error as? DocumentGroupError
            XCTAssertEqual(error, .noParentWindow)
        }
    }
}

private struct TestModal: DocumentGroupModal {

    var body: some View {
        Color.clear
    }
}
