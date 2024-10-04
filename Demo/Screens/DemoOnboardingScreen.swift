//
//  DemoOnboardingScreen.swift
//  Demo
//
//  Created by Daniel Saidi on 2023-05-26.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
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
                Text("Onboarding Page 1")
                Text("Onboarding Page 2")
                Text("Onboarding Page 3")
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
