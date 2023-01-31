import SwiftUI

struct PseudoLink<Content>: View where Content: View {
  let content: Content

  var body: some View {
    NavigationLink(
      destination: {
        EmptyView()
      },
      label: {
        content
      }
    )
      .buttonStyle(.plain)
  }

  init(@ViewBuilder content: () -> Content) {
    self.content = content()
  }
}
