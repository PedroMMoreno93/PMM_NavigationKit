//
//  HomeFlow.swift
//  PMM_NavigationKit
//
//  Created by Pedro M Moreno on 15/8/25.
//

import SwiftUI
import PMM_NavigationKit

public enum HomeFlow {
    @MainActor @ViewBuilder
    public static func build(_ route: HomeRoute) -> some View {
        switch route {
        case .root(let items):
            HomeView(items: items)
        case .detail(let item):
            DetailView(item: item)
        case .about:
            AboutView()
        }
    }
    
    @MainActor @ViewBuilder
    public static func buildSheet(
        _ route: HomeSheetRoute,
        onSave: @escaping (Item) -> Void
    ) -> some View {
        switch route {
        case .addItem:
            AddItemView(onSave: onSave)
        }
    }
    
    @MainActor @ViewBuilder
    public static func buildFull(
        _ route: HomeFullCoverRoute,
        onFinish: @escaping @MainActor () -> Void
    ) -> some View {
        switch route {
        case .onboarding:
            OnboardingIntroView()
                .navigationDestination(for: OnboardingStep.self) { step in
                    OnboardingStepView(step: step)
                }
        }
    }
    
}
