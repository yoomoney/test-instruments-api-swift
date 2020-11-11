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
import XCTest
import YooMoneyCoreApi

/// A closure used to validate a request that takes a `Task`.
public typealias ValidationClosure<M: ApiMethod> = (_ task: Task<M.Response>,
                                                    _ completion: @escaping ((_ failMessage: String?) -> Void)) -> Void

/// Utility class for test network request.
public class NetworkTest<M: ApiMethod> {

    init(session: ApiSession, testCase: XCTestCase) {
        self.session = session
        self.testCase = testCase
    }

    private init() {
        fatalError("Use instead method init(session: ApiSession, testCase: XCTestCase)")
    }

    /// Private variables
    private var timeout: TimeInterval = 30.0

    private var stubRequestBlock: OHHTTPStubsTestBlock?
    private var stubResponseBlock: OHHTTPStubsResponseBlock?

    private var validateBlock: ValidationClosure<M>!

    private let session: ApiSession
    private let testCase: XCTestCase

    /// Set timeout for wait performing network request.
    ///
    /// - Parameters:
    ///   - timeout: Timeout in seconds.
    ///
    /// - Returns: Self for chaining.
    public func set(timeout: TimeInterval) -> Self {
        self.timeout = timeout
        return self
    }

    /// Assign validation block for response.
    ///
    /// - Parameters:
    ///   - validateBlock: Validation block.
    ///
    /// - Returns: Self for chaining.
    public func validate(_ validateBlock: @escaping ValidationClosure<M>) -> Self {
        self.validateBlock = validateBlock
        return self
    }

    /// Stub specific request.
    ///
    /// - Parameters:
    ///   - stubRequestBlock: Stub request block.
    ///
    /// - Returns: Self for chaining
    @discardableResult public func stubRequest(_ stubRequestBlock: @escaping OHHTTPStubsTestBlock) -> Self {
        self.stubRequestBlock = stubRequestBlock
        return self
    }

    /// Stub response for specific request.
    ///
    /// - Parameters:
    ///   - stubResponseBlock: Stub response block.
    ///
    /// - Returns: Self for chaining.
    @discardableResult public func stubResponse(_ stubResponseBlock: @escaping OHHTTPStubsResponseBlock) -> Self {
        self.stubResponseBlock = stubResponseBlock
        return self
    }

    /// Stub request and assign stub response.
    ///
    /// - Parameters:
    ///   - apiMethod: Api method for stub.
    ///   - response: Stubs response.
    ///
    /// - Returns: Self for chaining.
    public func stub(apiMethod: M, response: OHHTTPStubsResponse) -> Self {
        stubRequest { request -> Bool in
            return request.httpMethod == apiMethod.httpMethod.rawValue
        }

        stubResponse { _ -> OHHTTPStubsResponse in
            return response
        }

        return self
    }

    /// Perform network request.
    ///
    /// - Parameters:
    ///   - apiMethod: Instance of apiMethod.
    public func perform(apiMethod: M) {
        let expectation = testCase.expectation(description: "expectation")
        var stubsDescriptor: OHHTTPStubsDescriptor?
        if let stubRequestBlock = stubRequestBlock, let stubResponseBlock = stubResponseBlock {
            stubsDescriptor = OHHTTPStubs.stubRequests(passingTest: stubRequestBlock,
                                                       withStubResponse: stubResponseBlock)
        }

        let task = session.perform(apiMethod: apiMethod)
        task.resume()

        validateBlock(task) {
            if let failMessage = $0 {
                XCTFail(failMessage)
            }
            expectation.fulfill()
        }

        testCase.waitForExpectations(timeout: timeout) { _ in
            if let stubsDescriptor = stubsDescriptor {
                OHHTTPStubs.removeStub(stubsDescriptor)
            }
        }
    }
}
