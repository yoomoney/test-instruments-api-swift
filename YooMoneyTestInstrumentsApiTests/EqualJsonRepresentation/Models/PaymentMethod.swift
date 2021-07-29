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

struct PaymentMethod: Encodable {
    let type: PaymentMethodType
    let id: String
    let saved: Bool
    let title: String?
    let cscRequired: Bool
    let card: PaymentMethodBankCard?

    init(
        type: PaymentMethodType,
        id: String,
        saved: Bool,
        title: String?,
        cscRequired: Bool,
        card: PaymentMethodBankCard?
    ) {
        self.type = type
        self.id = id
        self.saved = saved
        self.title = title
        self.cscRequired = cscRequired
        self.card = card
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)
        try container.encode(id, forKey: .id)
        try container.encode(saved, forKey: .saved)
        try container.encode(title, forKey: .title)
        try container.encode(cscRequired, forKey: .cscRequired)
        try container.encodeIfPresent(card, forKey: .card)
    }

    private enum CodingKeys: String, CodingKey {
        case type
        case id
        case saved
        case title
        case cscRequired = "csc_required"
        case card
    }
}
