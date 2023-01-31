import SwiftUI

struct RoundedCorners: Shape {
  let corners: UIRectCorner
  let radius: Double

  var radii: CGSize {
    CGSize(width: radius, height: radius)
  }

  init(corners: UIRectCorner = .allCorners, radius: Double = .zero) {
    self.corners = corners
    self.radius = radius
  }

  func path(in rect: CGRect) -> Path {
    Path(
      UIBezierPath(
        roundedRect: rect,
        byRoundingCorners: corners,
        cornerRadii: radii
      )
      .cgPath
    )
  }
}

extension View {
  func round(
    _ corners: UIRectCorner = .allCorners,
    radius: Double
  ) -> some View {
    let shape = RoundedCorners(corners: corners, radius: radius)
    return clipShape(shape)
  }
}
