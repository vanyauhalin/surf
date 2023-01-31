import SwiftUI

struct UserProfile: View {
  let user = User(name: "Иванов Иван", initials: "ИИ")

  var body: some View {
    PseudoLink {
      HStack(spacing: .zero) {
        VStack(alignment: .leading, spacing: 16) {
          Circle()
            .frame(width: 72)
            .foregroundColor(.avatar)
            .shadow(color: .avatarShadow, radius: 5, x: .zero, y: 4)
            .overlay {
              Text(user.initials)
                .foregroundColor(.white)
                .fontWeight(.bold)
            }
          HStack(spacing: .zero) {
            VStack(alignment: .leading, spacing: 2) {
              Text(user.name)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.foreground)
              Text("Мои личные данные")
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(.secondForeground)
            }
            Spacer()
            IconLink()
          }
        }
        Spacer()
      }
    }
      .padding()
  }
}
