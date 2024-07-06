//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func priceDidUpdate(price: String, currency: String)
    func didFail(with error: Error)
}

struct CoinManager {
    
    let baseURLString = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let API_KEY = "750120CB-4B30-470E-A75D-1278F4657EAA"
    var delegate: CoinManagerDelegate?
    //https://rest.coinapi.io/v1/exchangerate/BTC/USD?apikey=750120CB-4B30-470E-A75D-1278F4657EAA
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    
    
    
    func fetchPrice(for currency: String){
        if let baseUrl = URL(string: "\(baseURLString)/\(currency)?apikey=\(API_KEY)"){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: baseUrl) { data, response, error in
                if error == nil {
                    if let safeData = data{
                        if let stringRate = decodeData(data: safeData){
                            delegate?.priceDidUpdate(price: stringRate, currency: currency)
                        }
                    }
                }else{
                    delegate?.didFail(with: error!)
                }
            }
            task.resume()
        }
    }
    
    
    
    
    func decodeData(data: Data) -> String? {
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(CoinModel.self, from: data)
            return decodedData.roundedRate
        }catch{
            delegate?.didFail(with: error)
            return nil
        }
    }
    
}
