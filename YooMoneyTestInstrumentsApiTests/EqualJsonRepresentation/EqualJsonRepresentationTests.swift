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
import XCTest
@testable import YooMoneyTestInstrumentsApi

class EqualJsonRepresentationTests: YooMoneyTestInstrumentsApiTests {

    func testEqualJsonRepresentation() {
        let bankCard = PaymentMethodBankCard(
            first6: "427918",
            last4: "7918",
            expiryYear: "2017",
            expiryMonth: "07",
            cardType: .masterCard
        )

        let paymentMethod = PaymentMethod(
            type: .bankCard,
            id: "1da5c87d-0984-50e8-a7f3-8de646dd9ec9",
            saved: true,
            title: "Основная карта",
            cscRequired: true,
            card: bankCard
        )

        guard
            let jsonFileUrl = TestBundle.bundle.url(forResource: "PaymentMethod", withExtension: "json"),
            let data = try? Data(contentsOf: jsonFileUrl)
        else {
            XCTFail("Couldn't find PaymentMethod.json file")
            return
        }

        XCTAssertEqualJsonRepresentation(paymentMethod, data: data)
    }
}
