## 🎉 Release v1.0.0

**PMM NavigationKit 1.0.0** marks the initial stable release of **NavigationKit**. This version includes:
- `Coordinator` class to manage navigation flows (`push`, `sheet`, `fullCover`).
- `RootHostView` for seamless integration with SwiftUI `NavigationStack`.
- `.register` view modifier for type-safe navigation destinations (no `AnyView`).
- `ModalItem` model for clean modal management.
- Support for dismissal helpers (`dismissSheet`, `dismissFullCover`).
- Example apps included under `PMM_NavigationKitExamples/`:
    - **SimpleExample**: basic push navigation and detail views.
    - **HomeFlowExample**: demonstrates push navigation, sheets, and full screen covers.
