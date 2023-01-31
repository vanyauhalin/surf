import SwiftUI

struct ListItem: View {
  struct Style: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
      HStack {
        configuration.icon
        configuration.title
          .font(.subheadline)
          .fontWeight(.medium)
          .foregroundColor(.foreground)
        Spacer()
        IconLink()
      }
    }
  }

  let title: String
  let systemImage: String

  var body: some View {
    PseudoLink {
      Label(
        title: {
          Text(title)
        },
        icon: {
          Icon(systemImage: systemImage)
        }
      )
        .labelStyle(Style())
      Spacer()
    }
      .padding([.vertical], 8)
  }
}
