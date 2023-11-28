import SwiftUI

struct ContentView: View {

    @ObservedObject private var viewModel = LocationManager()

    var body: some View {
        VStack {
            Text("North: \((360 - viewModel.heading), specifier: "%.0f") degrees")
                .padding()

            Image(systemName: "location.north.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .rotationEffect(Angle(degrees: 360 - viewModel.heading))
        }
    }
}
