import SwiftUI

final class SplitScrollContainerModel: ObservableObject {
  init() {}

  // MARK: Container

  @Published
  var containerNamespace = UUID().uuidString

  var containerSpace: CoordinateSpace {
    .named(containerNamespace)
  }

  @Published
  var containerSize = CGSize(width: CGFloat.zero, height: .zero)

  func update(containerSize: CGSize) {
    self.containerSize = containerSize
  }

  // MARK: Foreground

  @Published
  var foregroundRectangle = CGRect.zero

  var foregroundOffset: CGFloat {
    foregroundRectangle.minY
  }

  func update(foregroundRectangle: CGRect) {
    self.foregroundRectangle = foregroundRectangle
  }

  // MARK: Background

  var backgroundHeight: CGFloat {
    if foregroundOffset >= containerSize.height {
      return containerSize.height
    }
    if foregroundOffset <= .zero {
      return .zero
    }
    return foregroundOffset
  }
}

struct SplitScrollContainer<Content>: View where Content: View {
  @ObservedObject
  var model: SplitScrollContainerModel
  let content: Content

  init(@ViewBuilder content: () -> Content) {
    self.model = SplitScrollContainerModel()
    self.content = content()
  }

  var body: some View {
    ScrollView {
      VStack(spacing: .zero) {
        content
        ZStack {
          GeometryReader { geometry in
            Color
              .clear
              .preference(
                key: SplitScrollContainerPreferenceKey.self,
                value: geometry.frame(in: model.containerSpace)
              )
          }
        }
      }
    }
      .readSize { size in
        model.update(containerSize: size)
      }
      .coordinateSpace(name: model.containerNamespace)
      .onPreferenceChange(SplitScrollContainerPreferenceKey.self) { rectangle in
        model.update(foregroundRectangle: rectangle)
      }
      .background(
        VStack(spacing: .zero) {
          Color
            .background
            .frame(height: model.backgroundHeight)
          Color
            .white
        }
      )
  }
}

private struct SplitScrollContainerPreferenceKey: PreferenceKey {
  static var defaultValue = CGRect.zero

  static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
    value = nextValue()
  }
}
