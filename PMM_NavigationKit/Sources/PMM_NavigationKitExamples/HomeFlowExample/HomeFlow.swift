//
//  HomeFlow.swift
//  PMM_NavigationKit
//
//  Created by Pedro M Moreno on 15/8/25.
//

import SwiftUI

public enum HomeFlow {
    @MainActor @ViewBuilder
    public static func build(_ route: HomeRoute) -> some View {
        switch route {
        case .root:
            HomeView()
        case .detail(let item):
            DetailView(item: item)
        }
    }
}
