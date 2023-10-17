//
//  DemoOnboardingScreen.swift
//  Demo
//
//  Created by Daniel Saidi on 2023-05-26.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import DocumentKit
import SwiftUI

struct DemoOnboardingScreen: View, DocumentGroupModal {

    init() {
        UIPageControl.appearance().pageIndicatorTintColor = .lightGray
        UIPageControl.appearance().currentPageIndicatorTintColor = .black
    }

    var body: some View {
        NavigationStack {
            TabView {
                Text("Page 1")
                Text("Page 2")
                Text("Page 3")
                Text("Page 4")
                Text("Page 5")
            }
            .withLeadingCloseButton()
            .navigationTitle("Onboarding")
            .tabViewStyle(.page(indexDisplayMode: .always))
        }
    }
}

struct DemoOnboardingScreen_Previews: PreviewProvider {
    static var previews: some View {
        DemoOnboardingScreen()
    }
}
