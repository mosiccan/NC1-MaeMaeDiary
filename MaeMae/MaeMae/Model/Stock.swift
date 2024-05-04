//
//  Book.swift
//  MaeMae
//
//  Created by Woowon Kang on 4/13/24.
//

import SwiftUI
import SwiftData

@Model
class Stock {
    @Attribute(.unique) var title: String // 종목명
    var summary: String  // 핵심 키워드
    var status: Status
    
    var dateAdded: Date // 작성일
    var dateStarted: Date // 매수시작일
    var dateCompleted: Date // 매도기간
    
    var targetBuyPrice: Int? // 목표 매수가
    var targetSellPrice: Int? // 목표 매도가
    var targetStocksCount: Int? // 매수 예정 수
    
    var profits: Int? // 이익
    var profitRate: Double? // 이익률
    
    @Relationship(inverse: \Journal.stock) var jornals: [Journal]?
    
    init(
        title: String,
        summary: String = "",
        status: Status = .onShelf,
    
        dateAdded: Date = Date.now,
        dateStarted: Date = Date.distantPast,
        dateCompleted: Date = Date.distantPast,
        
        targetBuyPrice: Int? = nil,
        targetSellPrice: Int? = nil,
        targetStocksCount: Int? = nil,
        
        profits: Int? = nil,
        profitRate: Double? = nil
        
    ) {
        self.title = title
        self.summary = summary
        self.status = status
        
        self.dateAdded = dateAdded
        self.dateStarted = dateStarted
        self.dateCompleted = dateCompleted
        
        self.targetBuyPrice = targetBuyPrice
        self.targetSellPrice = targetSellPrice
        self.targetStocksCount = targetStocksCount
        
        self.profits = profits
        self.profitRate = profitRate
        
    }
    
    var icon: Image {
        switch status {
        case .onShelf:
            Image(systemName: "circle")
        case .inProgress:
            Image(systemName: "circle.fill")
        case .completed:
            Image(systemName: "checkmark")
        }
    }
}

enum Status: Int, Codable, Identifiable, CaseIterable {
    case onShelf, inProgress, completed
    var id: Self {
        self
    }
    var descr: String {
        switch self {
        case .onShelf:
            "매매 예정"
        case .inProgress:
            "매매 진행 중"
        case .completed:
            "매매 완료"
        }
    }
}
