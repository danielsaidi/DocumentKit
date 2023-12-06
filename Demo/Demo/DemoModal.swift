//
//  DemoModal.swift
//  Demo
//
//  Created by Daniel Saidi on 2023-05-26.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import DocumentKit
import SwiftUI

struct DemoModal: View, DocumentGroupModal {

    var body: some View {
        NavigationStack {
            Text("Hello, modal!")
                .navigationTitle("Modal")
                .withLeadingCloseButton()
        }
    }
}

#Preview {
    
    DemoModal()
}
