//
//  NewBookView.swift
//  MaeMae
//
//  Created by Woowon Kang on 4/14/24.
//

import SwiftUI

struct NewStockView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) var dismiss
    @State private var title = ""
    @State private var summary = ""
    @State private var status = Status.onShelf
    
    @State private var dateAdded = Date()
    @State private var dateStarted = Date()
    @State private var dateCompleted = Date()
    
    @State private var targetStocksCount: Int = 0
    @State private var targetBuyPrice: Int = 0
    @State private var targetSellPrice: Int = 0
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("종목", text: $title)
                    .navigationTitle("새 종목")
                    .navigationBarTitleDisplayMode(.inline)
                
                Section(header: Text("매매 계획")) {
                    HStack {
                        Text("목표 매수가")
                        Spacer()
                        TextField("0원", value: $targetBuyPrice,  format: .currency(code: Locale.current.currency?.identifier ?? ""))
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
                    }
                    HStack {
                        Text("목표 매도가")
                        Spacer()
                        TextField("0원", value: $targetSellPrice, format: .currency(code: Locale.current.currency?.identifier ?? ""))
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
                    }
                    HStack {
                        Text("매수 예정 수")
                        Spacer()
                        TextField("0주", value: $targetStocksCount, formatter: NumberFormatter())
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
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
                
                HStack {
                    Text("목표 합산")
                    Spacer()
                    Text("이익 0, 이익률 0%")
                        .foregroundStyle(.secondary)
                }
                HStack {
                    Text("핵심 키워드")
                        .bold()
                    Spacer()
                    TextField("전략에 대한 키워드를 간단하게", text: $summary)
                        .multilineTextAlignment(.trailing)
                }
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("취소", role: .destructive) {
                            dismiss()
                        }
                        .foregroundStyle(.red)
                    }
                    if !title.isEmpty {
                            ToolbarItem(placement: .topBarTrailing) {
                                Button("완료") {
                                    createNewStock()
                                }
                                .bold()
                                .foregroundStyle(.blue)
                            }
                        }
                }
            }
            .navigationTitle("새 종목")
            .navigationBarTitleDisplayMode(.inline)
            
            
        }
    }
    
    func createNewStock() {
        let newStock = Stock(
            title: title,
            summary: summary,
            dateStarted: dateStarted,
            dateCompleted: dateCompleted,
            targetBuyPrice: targetBuyPrice,
            targetSellPrice: targetSellPrice,
            targetStocksCount: targetStocksCount
            
        )
        context.insert(newStock)
        dismiss()
    }
}

#Preview {
    NewStockView()
}
