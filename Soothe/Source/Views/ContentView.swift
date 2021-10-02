import SwiftUI

struct ContentView: View {
    var body: some View {
        HSplitView {
            SidebarView()
                .frame(width: 150)

            AboutView()
        }
        .frame(width: .width, height: .height)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)

        ContentView()
            .preferredColorScheme(.light)
    }
}
