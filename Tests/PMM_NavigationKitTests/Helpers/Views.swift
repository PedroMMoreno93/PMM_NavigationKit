//
//  Views.swift
//  PMM_NavigationKit
//
//  Created by Pedro M Moreno on 16/8/25.
//
import SwiftUI

internal struct DummyRootView: View {
    var body: some View { Text("Root") }
}

internal struct DummyDetailView: View {
    let id: Int
    var body: some View { Text("Detail \(id)") }
}
