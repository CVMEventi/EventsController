//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.
//

import Foundation
import Swifter

class ServerContainer {

    // MARK: - Properties

    static let shared = ServerContainer()

    // Initialization
    
    let server: HttpServer

    private init() {
        server = HttpServer()
    }
    
    public func addModules<Module>(_ modules: [Module.Type]) where Module: ServerModule {
        let module = Module()
        module.paths().forEach { (key, value) in
            server["/\(module.prefix)/\(key)"] = value
        }
        
    }
    
    public func start(port: UInt16) {
        try! server.start(port, forceIPv4: true)
    }
    
    public func stop() {
        server.stop()
    }

}
