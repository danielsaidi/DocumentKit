//
//  DemoCloseButton.swift
//  Demo
//
//  Created by Daniel Saidi on 2023-05-26.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

struct DemoLeadingCloseButtonViewModifier: ViewModifier {

    @Environment(\.dismiss)
    private var dismiss

    func body(content: Content) -> some View {
        content.toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Close", action: dismiss.callAsFunction)
            }
        }
    }
}

extension View {
    
    func withLeadingCloseButton() -> some View {
        self.modifier(DemoLeadingCloseButtonViewModifier())
    }
}

#Preview {
    
    NavigationStack {
        Color.red.withLeadingCloseButton()
    }
}
