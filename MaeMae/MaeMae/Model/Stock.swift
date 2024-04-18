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
    //안녕하세요. 저는 하래입니다. 이것은 아마 원의 노트북.. 인 것 같아 애ㅗ냐면 매수 매도 이러는건 원뿐이야...
    
    @Relationship(inverse: \Journal.stock) var jornals: [Journal]?
    
    init(
        title: String,
        summary: String = "",
        status: Status = .onShelf,
    
        dateAdded: Date = Date.now ,
        dateStarted: Date = Date.distantPast,
        dateCompleted: Date = Date.distantPast,
        
        targetBuyPrice: Int? = nil,
        targetSellPrice: Int? = nil,
        targetStocksCount: Int? = nil
        
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
