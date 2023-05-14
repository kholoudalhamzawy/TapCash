//
//  transferRequest.swift
//  TabCash
//
//  Created by KH on 14/05/2023.
//

import Foundation

struct TransferRequest {
    let amount: String
    let phone: String
    lazy var parameters =
    [[
      "key": "amount",
      "value": amount,
      "type": "text"
    ],
    [
      "key": "phone",
      "value": phone,
      "type": "text"
    ]] as [[String: Any]]
}
