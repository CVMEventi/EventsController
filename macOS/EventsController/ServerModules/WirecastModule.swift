//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.
//

import Foundation
import Swifter

class WirecastModule: ServerModule {
    let prefix: String = "wirecast"
    
    required init() {}
    
    func paths() -> [String : ((HttpRequest) -> HttpResponse)?] {
        return [
            "/open": { (request) in
                let result = WirecastAPI.open()
                return self.buildResponse(result: result)
            },
            "/layer/:layer/shot/:shot/autolive/:autolive": { (request) in
                let layer = Int(request.params[":layer"]!)!
                let shot = Int(request.params[":shot"]!)!
                let autolive = Int(request.params[":autolive"]!)! != 0
                
                let result = WirecastAPI.setShotForLayer(layer, shot: shot)
                if autolive {
                    _ = WirecastAPI.take()
                }
                return self.buildResponse(result: result)
            },
            "/shots/:shot1/:shot2/:shot3/:shot4/:shot5/autolive/:autolive": { (request) in
                let shot1 = Int(request.params[":shot1"]!)!
                let shot2 = Int(request.params[":shot2"]!)!
                let shot3 = Int(request.params[":shot3"]!)!
                let shot4 = Int(request.params[":shot4"]!)!
                let shot5 = Int(request.params[":shot5"]!)!
                let autolive = Int(request.params[":autolive"]!)! != 0
                
                let result = WirecastAPI.setShotForLayer(1, shot: shot1)
                _ = WirecastAPI.setShotForLayer(2, shot: shot2)
                _ = WirecastAPI.setShotForLayer(3, shot: shot3)
                _ = WirecastAPI.setShotForLayer(4, shot: shot4)
                _ = WirecastAPI.setShotForLayer(5, shot: shot5)
                if autolive {
                    _ = WirecastAPI.take()
                }
                return self.buildResponse(result: result)
            },
            "/take": { (request) in
                let result = WirecastAPI.take()
                return self.buildResponse(result: result)
            },
            "/start-recording": { (request) in
                let result = WirecastAPI.startRecording()
                return self.buildResponse(result: result)
            },
            "/stop-recording": { (request) in
                let result = WirecastAPI.stopRecording()
                return self.buildResponse(result: result)
            },
            "/start-broadcasting": { (request) in
                let result = WirecastAPI.startBroadcasting()
                return self.buildResponse(result: result)
            },
            "/stop-broadcasting": { (request) in
                let result = WirecastAPI.stopBroadcasting()
                return self.buildResponse(result: result)
            },
        ]
    }
    
    private func buildResponse(result: Result<Bool, APIError>) -> HttpResponse {
        switch result {
        case .success:
            return .ok(.json([
                "ok": true
            ]))
        case .failure(let apiError):
            if case let APIError.appleScriptError(description) = apiError {
                return getBadRequestResponse([
                    "ok": false,
                    "description": description
                ])
            } else {
                return getBadRequestResponse([
                    "ok": false,
                ])
            }
        }
    }
    
    private func getBadRequestResponse(_ json: Any) -> HttpResponse {
        let statusCode = 400
        let reasonPhrase = "Bad Request"
        let headers = ["Content-Type": "application/json"]
        
        let response =  HttpResponse.raw(statusCode, reasonPhrase , headers,  { writer in
            // jsonData represent your JSON string to return converted to `Data`
            // or any other implementing `HttpResponseBodyWriter`
            guard JSONSerialization.isValidJSONObject(json) else {
              throw SerializationError.invalidObject
            }
            let data = try JSONSerialization.data(withJSONObject: json)
            try writer.write(data)
        })
        
        return response
    }
}
