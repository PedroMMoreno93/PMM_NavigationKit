//
//  Routes.swift
//  SimpleExample
//
//  Created by Pedro M Moreno.
//

import Foundation

public enum HomeRoute: Hashable {
    case root(items: [Item])
    case detail(item: Item)
    case about
}

public enum HomeSheetRoute: Hashable {
    case addItem
}

public enum HomeFullCoverRoute: Hashable {
    case onboarding
}

public enum OnboardingStep: Hashable {
    case intro
    case coordinator
    case rootHost
    case register
    case modals
    case finish
}
