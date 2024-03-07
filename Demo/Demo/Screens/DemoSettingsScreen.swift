//
//  DemoSettingsScreen.swift
//  Demo
//
//  Created by Daniel Saidi on 2023-05-26.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import DocumentKit
import SwiftUI

struct DemoSettingsScreen: View, DocumentGroupModal {

    var body: some View {
        NavigationStack {
            Text("Settings")
                .navigationTitle("Settings")
                .withLeadingCloseButton()
        }
    }
}

struct DemoSettingsScreen_Previews: PreviewProvider {
    static var previews: some View {
        DemoSettingsScreen()
    }
}
