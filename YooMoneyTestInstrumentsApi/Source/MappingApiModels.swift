/*
 * The MIT License (MIT)
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
import XCTest

/// Responsible for mapping the API models.
open class MappingApiModels: XCTestCase {

    // MARK: - Resource properties

    /// Representation of resources stored in the Framework.
    public lazy var resourceBundle: Bundle = Bundle(for: type(of: self))

    // MARK: - Mapping api models

    /// The method is used to verify the sterilization of the API models.
    ///
    /// - Parameters:
    ///   - type: Type of the model.
    ///
    /// - Note:
    ///   - You need to create a file in the form of JSON from which your model will be obtained.
    ///   - The name of the file must be represent in `TypeName.json`
    ///
    /// - Example:
    ///   - If your type is `ExampleType`, name of file must be `ExampleType.json`
    ///
    /// - Returns: Tuple with named elements: `(data:, instance)`, where:
    ///            data: data from your JSON file
    ///            instance: JSON decoded instance from data
    public func mockWithType<T>(_ type: T.Type) -> (data: Data, instance: T)? where T: Decodable {
        return mock(type: type, fileName: String(describing: type))
    }

    /// The method is used to verify the sterilization of the API models.
    ///
    /// - Parameters:
    ///   - type: Type of the model.
    ///   - number:
    ///
    /// - Note:
    ///   - You need to create a file in the form of JSON from which your model will be obtained.
    ///   - The name of the file must be represent in `TypeName-number.json`
    ///
    /// - Example:
    ///   - If your type is `ExampleType`, name of file must be `ExampleType-number.json`, call this method
    ///     `mockWithType(Type.self, number: 0)`
    ///
    /// - Returns: Array of tuples with named elements: `(data:, instance)`, where:
    ///            data: data from your JSON file
    ///            instance: JSON decoded instance from data
    public func mockWithType<T>(_ type: T.Type, number: Int) -> [(data: Data, instance: T)]? where T: Decodable {
        let typeString = String(describing: type)
        let result = (0..<number).compactMap { mock(type: type, fileName: typeString + "\($0)") }
        return result.count == number ? result : nil
    }

    private func mock<T>(type: T.Type, fileName: String) -> (data: Data, instance: T)? where T: Decodable {
        guard let data = data(fromFileName: fileName) else {
            XCTFail("\(fileName) json is not found")
            return nil
        }
        guard let instance = try? JSONDecoder().decode(type, from: data) else {
            XCTFail("\(fileName) is not initialized")
            return nil
        }
        return (data, instance)
    }
}

// MARK: - MappingTests

extension MappingApiModels: MappingTests { }
