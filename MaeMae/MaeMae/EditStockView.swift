//
//  EditBookView.swift
//  MaeMae
//
//  Created by Woowon Kang on 4/14/24.
//

import SwiftUI

struct EditStockView: View {
    @Environment(\.dismiss) private var dismiss
    let stock: Stock
    @State private var status = Status.onShelf
    @State private var title = ""
    @State private var summary = ""
    @State private var dateAdded = Date.distantPast
    @State private var dateStarted = Date.distantPast
    @State private var dateCompleted = Date.distantPast
    @State private var firstView = true
    
    @State private var targetStocksCount: Int? = 0
    @State private var targetBuyPrice: Int? = 0
    @State private var targetSellPrice: Int? = 0
    
    var body: some View {
        
        Form {
            Section(header: Text("매매 계획")) {
                TextField("종목", text: $title)
            }
            
            Group {
                Section(header: Text("매매 계획")) {
                    HStack {
                        Picker("매매 상태", selection: $status) {
                            ForEach(Status.allCases) { status in
                                Text(status.descr).tag(status)
                            }
                        }
                        .buttonStyle(.bordered)
                    }
                    HStack {
                        Text("목표 매수가")
                        Spacer()
                        TextField("0원", value: $targetBuyPrice,  format: .currency(code: Locale.current.currency?.identifier ?? ""))
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                    }
                    HStack {
                        Text("목표 매도가")
                        Spacer()
                        TextField("0원", value: $targetSellPrice, format: .currency(code: Locale.current.currency?.identifier ?? ""))
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                    }
                    HStack {
                        Text("매수 예정 수")
                        Spacer()
                        HStack {
                                TextField("", value: $targetStocksCount, formatter: NumberFormatter())
                                    .keyboardType(.decimalPad)
                                    .multilineTextAlignment(.trailing)
                                Text("주")
                            }
                    }
                }
                GroupBox {
                    LabeledContent {
                        DatePicker("", selection: $dateStarted, in: dateAdded..., displayedComponents: .date )
                    } label: {
                        Text("매매 시작")
                    }
                    LabeledContent {
                        DatePicker("", selection: $dateCompleted, in: dateAdded..., displayedComponents: .date )
                    } label: {
                        Text("매매 종료")
                    }
                }
                .foregroundStyle(.secondary)
                .onChange(of: status) { oldValue, newValue in
                    if !firstView {
                        if newValue == .onShelf {
                            dateStarted = Date.distantPast
                            dateCompleted = Date.distantPast
                        } else if newValue == .inProgress && oldValue == .completed {
                            dateCompleted = Date.distantPast
                        } else if newValue == .inProgress && oldValue == .onShelf {
                            // Book has been started
                            dateStarted = Date.now
                        } else if newValue == .completed && oldValue == .onShelf {
                            // Forgot to start book
                            dateCompleted = Date.now
                            dateStarted = dateAdded
                        } else {
                            dateCompleted = Date.now
                        }
                        firstView = false
                    }
                }
                
                Section {
                    HStack {
                        Text("목표 합산")
                        Spacer()
                        Text("이익 0, 이익률 0%") // 목표 매수가, 목표 매도가, 매수 예정 수 입력 받아서 계산
                            .foregroundStyle(.secondary)
                    }
                }
                
                Section {
                    HStack {
                        Text("핵심 키워드")
                            .bold()
                        Spacer()
                        TextField("전략에 대한 키워드를 간단하게", text: $summary)
                            .multilineTextAlignment(.trailing)
                    }
                }
            }
            
        }
        .toolbar {
            if changed {
                Button("완료"){
                    stock.status = status
                    stock.title = title
                    stock.summary = summary
                    stock.dateAdded = dateAdded
                    stock.dateStarted = dateStarted
                    stock.dateCompleted = dateCompleted
                    stock.targetStocksCount = targetStocksCount
                    stock.targetBuyPrice = targetBuyPrice
                    stock.targetSellPrice = targetSellPrice
                    dismiss()
                }
                .bold()
                .foregroundStyle(.blue)
            }
            
        }
        .onAppear {
            status = stock.status
            title = stock.title
            summary = stock.summary
            dateAdded = stock.dateAdded
            dateStarted = stock.dateStarted
            dateCompleted = stock.dateCompleted
            targetStocksCount = stock.targetStocksCount
            targetBuyPrice = stock.targetBuyPrice
            targetSellPrice = stock.targetSellPrice
        }
      
    }
    
    
    var changed: Bool{
        status != stock.status
        || title != stock.title
        || summary != stock.summary
        || dateAdded != stock.dateAdded
        || dateStarted != stock.dateStarted
        || dateCompleted != stock.dateCompleted
        || targetStocksCount != stock.targetStocksCount
        || targetBuyPrice != stock.targetBuyPrice
        || targetSellPrice != stock.targetSellPrice
    }
}

//#Preview {
//    NavigationStack {
//        EditBookView()
//    }
//}
