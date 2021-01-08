//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.
//

import SwiftUI
import Defaults

struct SettingsView: View {
    @Default(.port) var port
    let addresses = getIFAddresses().joined(separator: ", ")
    @State var color: Color = ServerContainer.shared.server.operating ? .green : .red
    
    var body: some View {
        VStack {
            Button {
                NSWorkspace.shared.open(URL(string: "https://cvm.it")!)
            } label: {
                Image("CompanyLogo")
            }.buttonStyle(PlainButtonStyle())
            Text("EventsController").font(.headline)
            if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
                Text("Version: \(version)")
            }
            Divider().padding(.vertical, 5)
            HStack {
                Text("Status:")
                Circle()
                    .foregroundColor(color)
                    .frame(width: 15, height: 15)
            }
            Text("IP: \(addresses)")
            HStack {
                Text("Port:")
                TextField("Port", value: $port, formatter: NumberFormatter()).padding(.horizontal)
                Button("Set") {
                    color = .red
                    ServerContainer.shared.stop()
                    ServerContainer.shared.start(port: port)
                    // Check after 1 second if server is started
                    DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + DispatchTimeInterval.seconds(1)) {
                        print(ServerContainer.shared.server.state)
                        color = ServerContainer.shared.server.operating ? .green : .red
                    }
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("PopoverAppeared"))) { (obj) in
            color = ServerContainer.shared.server.operating ? .green : .red
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
