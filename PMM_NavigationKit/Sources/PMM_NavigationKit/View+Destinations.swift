//
//  View+Destinations.swift
//  PMM_NavigationKit
//
//  Created by Pedro M Moreno.
//
import Foundation
import SwiftUI

public extension View {
    /// Registers navigation destinations for a specific route type.
    func register<Route: Hashable, Destination: View>(
        _ route: Route.Type,
        @ViewBuilder builder: @escaping (Route) -> Destination
    ) -> some View {
        self.navigationDestination(for: Route.self) { route in
            builder(route)
        }
    }
}
