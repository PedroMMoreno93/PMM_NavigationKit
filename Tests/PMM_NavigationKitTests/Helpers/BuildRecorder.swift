//
//  BuildRecorder.swift
//  PMM_NavigationKit
//
//  Created by Pedro M Moreno on 16/8/25.
//

import SwiftUI

@MainActor
internal final class BuildRecorder {
    var built: [DummyRoute] = []
    func record(_ route: DummyRoute) { built.append(route) }
}
