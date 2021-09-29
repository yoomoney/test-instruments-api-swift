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

struct PaymentMethodBankCard: Encodable {
    let first6: String
    let last4: String
    let expiryYear: String
    let expiryMonth: String
    let cardType: BankCardType

    init(
        first6: String,
        last4: String,
        expiryYear: String,
        expiryMonth: String,
        cardType: BankCardType
    ) {
        self.first6 = first6
        self.last4 = last4
        self.expiryYear = expiryYear
        self.expiryMonth = expiryMonth
        self.cardType = cardType
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(first6, forKey: .first6)
        try container.encode(last4, forKey: .last4)
        try container.encode(expiryYear, forKey: .expiryYear)
        try container.encode(expiryMonth, forKey: .expiryMonth)
        try container.encode(cardType, forKey: .cardType)
    }

    private enum CodingKeys: String, CodingKey {
        case first6
        case last4
        case expiryYear = "expiry_year"
        case expiryMonth = "expiry_month"
        case cardType = "card_type"
    }
}
