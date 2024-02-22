//
//  CoinModel.swift
//  ByteCoin
//
//  Created by shilani on 21/02/2024.
//  Copyright © 2024 The App Brewery. All rights reserved.
//

import Foundation
struct CoinModel: Codable {
    let rate: Double 
    var roundedRate: String {
        return String(format: "%.2f", rate)
    }
}
