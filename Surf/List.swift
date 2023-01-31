import SwiftUI

struct List: View {
  var body: some View {
    VStack(alignment: .leading) {
      ListItem(title: "Промокоды и подписки", systemImage: "rublesign")
      ListItem(title: "Настройки", systemImage: "slider.horizontal.3")
      ListItem(title: "Пользовательское соглашение", systemImage: "note.text")
      ListItem(title: "Связаться с нами", systemImage: "envelope")
    }
      .padding([.horizontal])
      .frame(maxWidth: .infinity)
  }
}
