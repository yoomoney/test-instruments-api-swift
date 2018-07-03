/*
 * The MIT License
 *
 * Copyright (c) 2007—2018 NBCO Yandex.Money LLC
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
import FunctionalSwift
import XCTest
import YandexMoneyCoreApi

/// Responsible for validating the API method.
open class ApiMethodTestCase: XCTestCase {

    // MARK: - Method test methods

    /// Performs validation for api method
    ///
    /// - Parameters:
    ///   - responseType: Response type
    ///   - apiMethod: Api method
    ///   - stubsResponse: Stubs response
    ///   - verify: Will be called after stubs response retrieved or in case of error
    public func validate<M: ApiMethod>(
        _ apiMethod: M,
        _ stubsResponse: StubsResponse.Type,
        _ testClass: Swift.AnyClass,
        verify: @escaping (Result<M.Response>) -> Void) {

        NetworkTest<M>(session: session, testCase: self)
            .set(timeout: stubTimeout)
            .stub(apiMethod: apiMethod,
                  response: stubsResponse.ohhttpStubsResponse(for: testClass))
            .validate { task, completion in
                task.responseApi { result in
                    switch result {
                    case .right(let value):
                        verify(.right(value))
                    case .left(let error):
                        verify(.left(error))
                    }
                    completion(nil)
                }
            }
            .perform(apiMethod: apiMethod)
    }

    // MARK: - Method test properties

    private let session: ApiSession = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = DefaultHeadersFactory(userAgent: "UnitTest").makeHeaders().value
        let session = ApiSession(hostProvider: TestHostProvider())
        return session
    }()

    private let stubTimeout: TimeInterval = 5.0
}
