//
//  StockSamples.swift
//  MaeMae
//
//  Created by Woowon Kang on 4/17/24.
//

import Foundation

extension Stock {
    static let lastWeek = Calendar.current.date(byAdding: .day, value: -7, to: Date.now)!
    static let lastMonth = Calendar.current.date(byAdding: .month, value: -1, to: Date.now)!
    static var sampleStocks: [Stock] {
        [
            Stock(title: "애플",
                  summary: "WWDC 직전에 매도",
                  
                  targetSellPrice: 190
                 ),
            Stock(title: "알파벳",
                  summary: "장 박살나면 매수",
                  status: Status.inProgress,
                  
                  dateAdded: lastWeek,
                  dateStarted: Date.now,
                  
                  targetSellPrice: 200
                 )
        ]
        
    }
}
