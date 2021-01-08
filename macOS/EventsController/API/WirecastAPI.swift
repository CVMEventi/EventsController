//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.
//

import Foundation

class WirecastAPI {
    static func call(script: String) -> Result<Bool, APIError> {
        let scriptRunner = NSAppleScript(source: script)
        var error: NSDictionary?
        scriptRunner?.executeAndReturnError(&error)
        if let err = error {
            return .failure(APIError.appleScriptError(description: err["NSAppleScriptErrorMessage"] as! String))
        }
        
        return .success(true)
    }
    
    static func open() -> Result<Bool, APIError> {
        let script = """
        tell application "Wirecast"
            open
        end tell
        """
        
        return call(script: script)
    }
    
    static func setShotForLayer(_ layer: Int, shot: Int) -> Result<Bool, APIError> {
        let script = """
        tell application "Wirecast"
            set current_layer to the layer \(layer) of last document
            set active shot of current_layer to shot \(shot) of current_layer
        end tell
        """
        
        return call(script: script)
    }
    
    static func take() -> Result<Bool, APIError> {
        let script = """
        tell application "Wirecast"
            go last document
        end tell
        """
        
        return call(script: script)
    }
    
    static func startRecording() -> Result<Bool, APIError> {
        let script = """
        tell application "Wirecast"
            start recording last document
        end tell
        """
        
        return call(script: script)
    }
    
    static func stopRecording() -> Result<Bool, APIError> {
        let script = """
        tell application "Wirecast"
            stop recording last document
        end tell
        """
        
        return call(script: script)
    }
    
    static func startBroadcasting() -> Result<Bool, APIError> {
        let script = """
        tell application "Wirecast"
            start broadcasting last document
        end tell
        """
        
        return call(script: script)
    }
    
    static func stopBroadcasting() -> Result<Bool, APIError> {
        let script = """
        tell application "Wirecast"
            stop broadcasting last document
        end tell
        """
        
        return call(script: script)
    }
}
