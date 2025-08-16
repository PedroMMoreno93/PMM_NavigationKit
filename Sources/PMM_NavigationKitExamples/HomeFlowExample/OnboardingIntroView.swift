//
//  OnboardingIntroView.swift
//  PMM_NavigationKit
//
//  Created by Pedro M Moreno on 16/8/25.
//

import SwiftUI
import PMM_NavigationKit

struct OnboardingIntroView: View {
    @EnvironmentObject private var coordinator: Coordinator

    var body: some View {
        VStack(spacing: 20) {
            Text("Welcome to NavigationKit")
                .font(.largeTitle.bold())

            Text("""
            A tiny SDK that centralizes navigation using a Coordinator and a RootHostView.
            In this guided flow, you'll see why it exists and how to integrate it.
            """)
            .multilineTextAlignment(.center)
            .foregroundStyle(.secondary)

            VStack(alignment: .leading, spacing: 8) {
                Label("Decoupled navigation logic", systemImage: "arrow.left.arrow.right")
                Label("Type-safe routes (no AnyView)", systemImage: "checkmark.seal")
                Label("Push + Sheet + Full-screen", systemImage: "square.on.square")
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            Spacer()

            Button {
                coordinator.fullCoverPath.append(OnboardingStep.coordinator)
            } label: {
                Text("Start guided tour").frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .navigationTitle("Onboarding")
    }
}
