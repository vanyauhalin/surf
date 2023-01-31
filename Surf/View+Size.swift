import SwiftUI

struct SizePreferenceKey: PreferenceKey {
  static var defaultValue = CGSize.zero

  static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}

extension View {
  func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
    self
      .background(
        GeometryReader { geometry in
          Color
            .clear
            .preference(key: SizePreferenceKey.self, value: geometry.size)
        }
      )
      .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
  }
}
