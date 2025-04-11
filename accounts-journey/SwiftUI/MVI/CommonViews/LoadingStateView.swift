import SwiftUI

struct LoadingStateView: View {
    var body: some View {
        VStack {
            Text("Loading...")
                .fontWeight(.light)
                .padding()
                .foregroundStyle(.gray)
            ProgressView()
                .progressViewStyle(.circular)
                .scaleEffect(1.5)
        }

    }
}

#Preview {
    LoadingStateView()
}
