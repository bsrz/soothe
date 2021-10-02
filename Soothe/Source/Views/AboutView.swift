import SwiftUI

struct AboutView: View {
    var body: some View {
        List {
            Text("About Soothe")
                .font(.title)
                .padding([.top, .trailing, .bottom], 20)

            Text("This Xcode extension is open sourced. For any questions or bugs, please create a new issue:")
            Link("https://github.com/bsarrazin/soothe", destination: URL(string: "https://github.com/bsarrazin/soothe")!)
                .padding(.bottom, 20)

            Text("If you do not see the extension in Xcode's editor menu, make sure you have enabled it in the system preferences.")
            Text("1. Open System Preferences")
            Text("2. Go to Extensions")
            Text("3. Select \"Xcode Source Editor\" on the left")
            Text("4. Ensure the checkbox for Soothing is checked")
        }
    }
}
