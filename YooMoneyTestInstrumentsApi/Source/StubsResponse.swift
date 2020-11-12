/*
 * The MIT License
 *
 * Copyright © 2020 NBCO YooMoney LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import Foundation
import OHHTTPStubs

/// Response protocol for stub network
public protocol StubsResponse {

    /// HTTP status code
    static var statusCode: Int32 { get }

    /// Headers
    static var headers: [AnyHashable: Any]? { get }

    /// File name of response
    static var fileName: String { get }

    /// File extension of response
    static var fileExtension: String { get }
}

// MARK: - Default implementation of protocol

public extension StubsResponse {

    /// Headers
    static var headers: [AnyHashable: Any]? {
        return ["Content-Type": "application/json"]
    }

    /// File extension of response
    static var fileExtension: String {
        return "json"
    }

    /// File name of response
    static var fileName: String {
        return String(describing: self)
    }

    /// HTTP status code
    static var statusCode: Int32 {
        return 200
    }
}

public extension StubsResponse {

    /// Creates instance of `OHHTTPStubsResponse`.
    ///
    /// - Parameters:
    ///   - testClass: Type of instance.
    ///
    /// Returns: Instance of `OHHTTPStubsResponse`.
    static func ohhttpStubsResponse(for testClass: Swift.AnyClass) -> OHHTTPStubsResponse {
        guard let filePath = Bundle(for: testClass)
            .path(forResource: fileName,
                  ofType: fileExtension) else {
            fatalError("Response file not found: " + fileName + "." + fileExtension)
        }
        return OHHTTPStubsResponse(fileAtPath: filePath,
                                   statusCode: statusCode,
                                   headers: headers)
    }
}
