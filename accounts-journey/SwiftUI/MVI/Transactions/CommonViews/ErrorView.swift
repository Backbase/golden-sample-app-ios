import SwiftUI

public struct ErrorView: View {

    let message: String
    let onRefresh: () -> Void

    public init(message: String, onRefresh: @escaping () -> Void) {
        self.message = message
        self.onRefresh = onRefresh
    }

    public var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                Image(systemName: "exclamationmark.triangle")
                    .font(.largeTitle)
                    .foregroundStyle(.red)
                Text("Something went wrong...\n(\(message))")
                    .padding()
                    .fontWeight(.semibold)
                    .foregroundStyle(.red)
                    .multilineTextAlignment(.center)
                Text("Pull down to retry")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .padding(.top, 8)
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .refreshable {
            onRefresh()
        }
    }
}

#Preview {
    ErrorView(message: "Internal server error", onRefresh: {})
}
