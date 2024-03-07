//
//  ContentView.swift
//  Demo
//
//  Created by Daniel Saidi on 2023-05-26.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @Binding 
    var document: DemoDocument

    var body: some View {
        TextEditor(text: $document.text)
    }
}

#Preview {
    
    ContentView(
        document: .constant(DemoDocument())
    )
}
