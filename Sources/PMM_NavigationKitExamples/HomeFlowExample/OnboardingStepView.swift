//
//  OnboardingStepView.swift
//  PMM_NavigationKit
//
//  Created by Pedro M Moreno on 16/8/25.
//

import SwiftUI
import PMM_NavigationKit

public struct OnboardingStepView: View {
    @EnvironmentObject private var coordinator: Coordinator
    let step: OnboardingStep

    public init(
        step: OnboardingStep
    ) {
        self.step = step
    }
    
    public var body: some View {
        VStack(spacing: 16) {
            Text(title(for: step)).font(.title.bold())
            Text(subtitle(for: step))
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.leading)

            GroupBox {
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(points(for: step), id: \.self) { line in
                        HStack(alignment: .top, spacing: 8) {
                            Image(systemName: "chevron.right")
                                .padding(.top, 2)
                            Text(line)
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }

            Spacer()

            HStack {
                if canGoBack(step) {
                    Button("Back") {
                        if !coordinator.fullCoverPath.isEmpty {
                            coordinator.fullCoverPath.removeLast()
                        }
                    }
                    .buttonStyle(.bordered)
                }

                Spacer()

                Button(primaryCTA(step)) {
                    if let next = nextStep(after: step) {
                        coordinator.fullCoverPath.append(next)
                    } else {
                        coordinator.dismissFullCover()
                    }
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .padding()
        .navigationTitle(stepNavTitle(step))
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - copy & helpers
    private func title(for s: OnboardingStep) -> String {
        switch s {
        case .coordinator: return "Coordinator"
        case .rootHost:    return "RootHostView"
        case .register:    return "Register Destinations"
        case .modals:      return "Sheets & Full-Screen"
        case .finish:      return "You're Ready!"
        case .intro:       return "Intro"
        }
    }
    
    private func stepNavTitle(_ s: OnboardingStep) -> String {
        switch s {
        case .coordinator: return "Step 1/5"
        case .rootHost:    return "Step 2/5"
        case .register:    return "Step 3/5"
        case .modals:      return "Step 4/5"
        case .finish:      return "Step 5/5"
        case .intro:       return "Intro"
        }
    }
    
    private func subtitle(for s: OnboardingStep) -> String {
        switch s {
        case .coordinator: return "One observable object owns push/sheet/full-screen paths."
        case .rootHost:    return "Thin host for the root NavigationStack. Keep .register inside the root."
        case .register:    return "Map each route case to its destination view. Type-safe, no AnyView."
        case .modals:      return "Present sheets/full covers by item; use paths for in-modal steps."
        case .finish:      return "You can now combine push + sheets + full-screen flows cleanly."
        case .intro:       return ""
        }
    }
    
    private func points(for s: OnboardingStep) -> [String] {
        switch s {
        case .coordinator:
            return [
                "Published paths: path, sheetPath, fullCoverPath.",
                "Present/dismiss with sheetItem/fullCoverItem.",
                "show(_:) for push; back()/reset() to pop/clear."
            ]
        case .rootHost:
            return [
                "Holds NavigationStack(path: $coordinator.path).",
                "Receives your typed root view.",
                "Attach .register(...) **inside** the root."
            ]
        case .register:
            return [
                ".register(Route.self) { route in switch route { ... } }",
                "No AnyView — compiler preserves types.",
                "Stack multiple registers for feature routes."
            ]
        case .modals:
            return [
                "Present: coordinator.presentSheet / presentFullCover.",
                "Root is driven by the item (no placeholders).",
                "Bind path for in-modal navigation steps."
            ]
        case .finish:
            return [
                "Single source of truth.",
                "Type-safe routes, simple flows.",
                "DI optional, not required."
            ]
        case .intro:
            return []
        }
    }
    
    private func nextStep(after s: OnboardingStep) -> OnboardingStep? {
        switch s {
        case .coordinator: return .rootHost
        case .rootHost:    return .register
        case .register:    return .modals
        case .modals:      return .finish
        case .finish, .intro: return nil
        }
    }
    
    private func primaryCTA(_ s: OnboardingStep) -> String {
        switch s {
        case .coordinator, .rootHost, .register, .modals: return "Next"
        case .finish: return "Close"
        case .intro:  return "Start"
        }
    }
    
    private func canGoBack(_ s: OnboardingStep) -> Bool {
        switch s {
        case .coordinator, .rootHost, .register, .modals: return true
        case .finish, .intro: return false
        }
    }
}
