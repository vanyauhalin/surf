import SwiftUI

extension Color {
  static var avatar: Color {
    Color(
      red: Double(137) / 255,
      green: Double(152) / 255,
      blue: Double(154) / 255
    )
  }

  static var avatarShadow: Color {
    avatar.opacity(0.35)
  }

  static var background: Color {
    Color(
      red: Double(246) / 255,
      green: Double(247) / 255,
      blue: Double(249) / 255
    )
  }

  static var secondForeground: Color {
    Color(
      red: Double(170) / 255,
      green: Double(179) / 255,
      blue: Double(182) / 255
    )
  }

  static var foreground: Color {
    Color (
      red: Double(20) / 255,
      green: Double(20) / 255,
      blue: Double(20) / 255
    )
  }
}
