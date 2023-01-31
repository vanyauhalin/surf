import SwiftUI

struct NavigationToolbar: View {
  var body: some View {
    HStack {
      Button(
        action: {},
        label: {
          Icon(systemImage: "arrow.left")
        }
      )
        .buttonStyle(.plain)
        .padding()
      Spacer()
    }
      .background {
        Rectangle()
          .foregroundColor(.background)
      }
  }
}
