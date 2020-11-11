import XCTest

public extension XCTest {

    /// Asserts that two instances are equal.
    ///
    /// - Parameters:
    ///   - instance: Type of instance.
    ///   - data: Instance represented in Data from JSON.
    func XCTAssertEqualJsonRepresentation<T>(_ instance: T, data: Data) where T: Encodable {
        guard let instanceData = try? JSONEncoder().encode(instance),
              let _instanceJson = try? JSONSerialization.jsonObject(with: instanceData),
              let instanceJson = _instanceJson as? [AnyHashable: Any] else {
            XCTFail("\(type(of: instance)) has no Json representation")
            return
        }

        guard let _dataJson = try? JSONSerialization.jsonObject(with: data),
              let dataJson = _dataJson as? [AnyHashable: Any] else {
            XCTFail("\(data) in not valid Json")
            return
        }

        XCTAssert(NSDictionary(dictionary: instanceJson).isEqual(to: dataJson),
                  "\(type(of: instance)) wrong json mapping")
    }
}
