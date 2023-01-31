import SwiftUI

struct ContentContainer<Content>: View where Content: View {
  let content: Content

  var body: some View {
    VStack(spacing: .zero) {
      content
    }
      .background {
        Color.background.ignoresSafeArea()
      }
  }

  init(@ViewBuilder content: () -> Content) {
    self.content = content()
  }
}
