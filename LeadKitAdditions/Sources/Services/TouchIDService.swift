//
//  Copyright (c) 2018 Touch Instinct
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the Software), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED AS IS, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import LocalAuthentication

public typealias TouchIDServiceAuthHandler = (Bool) -> Void

/// Represents service that provides access to authentication via touch id
public class TouchIDService {

    private lazy var laContext: LAContext = {
        return LAContext()
    }()

    public init() {}

    /// Indicates is it possible to authenticate on this device via touch id
    public var canAuthenticateByTouchId: Bool {
        return laContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
    }

    /**
     Initiates system touch id authentication process

      - parameters:
        - description: prompt on the system alert that describes what for user should attach finger to device
        - authHandler: callback, with parameter, indicates if user authenticate successfuly
     */
    public func authenticateByTouchId(description: String, authHandler: @escaping TouchIDServiceAuthHandler) {
        laContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                                 localizedReason: description) { success, _ in

            authHandler(success)
        }
    }

}
