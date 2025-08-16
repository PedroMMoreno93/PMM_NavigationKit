//
//  OnboardingView.swift
//  PMM_NavigationKit
//
//  Created by Pedro M Moreno.
//

import SwiftUI
import PMM_NavigationKit

public struct OnboardingView: View {
    let onFinish: @MainActor () -> Void
    
    public init(onFinish: @escaping @MainActor () -> Void) {
        self.onFinish = onFinish
    }
    
    public var body: some View {
        VStack(spacing: 20) {
            Text("Welcome to NavigationKit")
                .font(.largeTitle.bold())
            Text("This is a simple onboarding presented as a full-screen cover.")
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
            Button("Start") { onFinish() }
                .buttonStyle(.borderedProminent)
        }
        .padding()
        .navigationTitle("Onboarding")
    }
}
