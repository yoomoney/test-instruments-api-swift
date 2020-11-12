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

import XCTest
import YooMoneyCoreApi

/// Responsible for mapping the API method.
open class MappingApiMethods: XCTestCase {

    // MARK: - Resource properties

    /// Representation of resources stored in the Framework.
    public lazy var resourceBundle: Bundle = Bundle(for: type(of: self))

    // MARK: - Mapping api methods

    /// The method is used to verify the serialization of the API method.
    ///
    /// - Parameters:
    ///   - apiMethodType: Type of the API method.
    ///   - fileName: The name of the file as JSON.
    ///   - index: File index.
    ///
    /// - Note:
    ///   - You need to create a file in the form of JSON from which your model will be obtained.
    ///   - The name of the file must be represent in syntax `filename-index.json`
    ///
    /// - Example:
    ///   - If file name is `filename-0.json`, call this method
    ///     `checkApiMethodsParameters(Type.self, filename: filename, index: 0)`
    public func checkApiMethodsParameters<T: Codable>(
        _ apiMethodType: T.Type,
        fileName: String? = nil,
        index: Int) {

        let fileName = (fileName ?? "\(apiMethodType)") + "-\(index)"
        guard let jsonData = self.data(fromFileName: fileName),
              let _json = try? JSONSerialization.jsonObject(with: jsonData),
              let json = _json as? [AnyHashable: Any] else {
            XCTFail("Not valid json at file \(fileName)")
            return
        }

        guard let apiMethod = try? JSONDecoder().decode(apiMethodType, from: jsonData) else {
            XCTFail("Fail decode object \(apiMethodType)")
            return
        }

        guard let modelData = try? JSONEncoder().encode(apiMethod),
              let _json2 = try? JSONSerialization.jsonObject(with: modelData),
              let json2 = _json2 as? [AnyHashable: Any] else {
            XCTFail("Fail encode object \(apiMethod)")
            return
        }

        XCTAssertTrue(NSDictionary(dictionary: json).isEqual(to: json2))
    }
}

// MARK: - MappingTests

extension MappingApiMethods: MappingTests {}
