import SwiftUI

struct ContentView: View {
  var body: some View {
    NavigationStack {
      ContentContainer {
        NavigationToolbar()
        SplitScrollView(
          header: {
            UserProfile()
          },
          content: {
            List()
          }
        )
        PseudoLink {
          Label(
            title: {
              Text("Выйти")
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(.foreground)
            },
            icon: {
              Icon(systemImage: "rectangle.portrait.and.arrow.right")
            }
          )
          Spacer()
        }
          .padding()
          .frame(maxWidth: .infinity)
          .background(.white)
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
