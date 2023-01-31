import SwiftUI

struct SplitScrollView<Header, Content>: View
where Header: View, Content: View {
  let header: Header
  let content: Content

  var body: some View {
    SplitScrollContainer {
      VStack(spacing: .zero) {
        header
        LazyVStack(
          alignment: .leading,
          spacing: .zero,
          pinnedViews: .sectionHeaders
        ) {
          Section(
            content: {
              content
                .background(.white)
            },
            header: {
              ZStack {
                Rectangle()
                  .foregroundColor(.background)
                Rectangle()
                  .frame(height: .zero)
                  .foregroundColor(.clear)
                  .padding()
                  .background {
                    Color
                      .white
                      .round([.topLeft, .topRight], radius: 20)
                  }
              }
            }
          )
        }
      }
    }
  }

  init(
    @ViewBuilder header: () -> Header,
    @ViewBuilder content: () -> Content
  ) {
    self.header = header()
    self.content = content()
  }
}
