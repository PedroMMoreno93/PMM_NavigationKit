//
//  AboutView.swift
//  PMM_NavigationKit
//
//  Created by Pedro M Moreno.
//

import SwiftUI

public struct AboutView: View {
    
    public init() {
    }
    
    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("NavigationKit")
                    .font(.largeTitle.bold())

                Group {
                    Text("What is it?")
                        .font(.title3.bold())
                    Text("""
                    A tiny SDK that centralizes navigation with a Coordinator and a RootHostView. It keeps views focused on UI.
                    """)
                }

                Group {
                    Text("Core concepts")
                        .font(.title3.bold())
                    Label("Coordinator manages NavigationPath and modals", systemImage: "square.stack.3d.up")
                    Label("RootHostView hosts the NavigationStack", systemImage: "rectangle.stack")
                    Label(".register(Route.self) binds routes → views", systemImage: "link")
                    Label("Sheets & full-screen covers use sheetItem/fullCoverItem", systemImage: "square.on.square")
                }

                Group {
                    Text("Tips")
                        .font(.title3.bold())
                    Text("• Apply `.register(...)` **inside** the root passed to RootHostView.\n• Provide a single Coordinator via `.environmentObject`.\n• No AnyView needed.")
                        .font(.callout)
                        .foregroundStyle(.secondary)
                }
            }
            .padding()
        }
        .navigationTitle("About")
    }
}
