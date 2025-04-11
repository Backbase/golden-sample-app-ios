import SwiftUI

struct ErrorView: View {

    let message: String

    var body: some View {
        VStack(alignment: .center) {
            Image(systemName: "exclamationmark.triangle")
                .font(.largeTitle)
                .foregroundStyle(.red)
            Text("Something went wrong...\n(\(message))")
                .padding()
                .fontWeight(.semibold)
                .foregroundStyle(.red)
                .multilineTextAlignment(.center)
        }
        .padding()
    }
}

#Preview {
    ErrorView(message: "Internal server error")
}
