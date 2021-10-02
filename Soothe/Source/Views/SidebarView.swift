import SwiftUI

struct SidebarView: View {
    var body: some View {
        VStack {
            Image("main")
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .frame(maxHeight: .height * 0.4)
                .padding(.top, 20)

            Text("Soothe")
                .font(.title)
                .padding()

            Text("Soothe is a collection of Xcode editor commands that helps with development.")
                .font(.body)
                .padding()

            Spacer()
        }
    }
}
