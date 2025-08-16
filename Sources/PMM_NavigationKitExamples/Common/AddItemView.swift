//
//  AddItemView.swift
//  PMM_NavigationKit
//
//  Created by Pedro M Moreno.
//

import SwiftUI
import PMM_NavigationKit

public struct AddItemView: View {
    @EnvironmentObject private var coordinator: Coordinator
    @State private var title: String = ""
    let onSave: (Item) -> Void

    public init(
        onSave: @escaping (Item) -> Void
    ) {
        self.onSave = onSave
    }
    
    public var body: some View {
        Form {
            Section("New item") {
                TextField("Title", text: $title)
                    .textInputAutocapitalization(.words)
            }
            Section {
                Button("Save") {
                    onSave(
                        Item(title: self.title)
                    )
                    coordinator.dismissSheet()
                }
                .disabled(title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }
        }
        .navigationTitle("Add Item")
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Close") { coordinator.dismissSheet() }
            }
        }
    }
}
