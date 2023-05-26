//
//  ContentView.swift
//  Demo
//
//  Created by Daniel Saidi on 2023-05-26.
//

import SwiftUI

struct ContentView: View {
    @Binding var document: DemoDocument

    var body: some View {
        TextEditor(text: $document.text)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(document: .constant(DemoDocument()))
    }
}
