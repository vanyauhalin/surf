import SwiftUI

struct Icon: View {
  static let width = Double(28)

  @ScaledMetric
  private var scale = 1

  let systemImage: String

  var body: some View {
    Image(systemName: systemImage)
      .font(.callout)
      .fontWeight(.medium)
      .foregroundColor(.foreground)
      .frame(width: Icon.width * scale)
  }

  init(systemImage: String) {
    self.systemImage = systemImage
  }
}

struct IconLink: View {
  static let width = Double(28)

  @ScaledMetric
  private var scale = 1

  let systemImage = "chevron.right"

  var body: some View {
    Image(systemName: systemImage)
      .font(.callout)
      .fontWeight(.medium)
      .foregroundColor(.avatar)
      .frame(width: Icon.width * scale)
  }
}
