//
//  JournalSelectView.swift
//  MaeMae
//
//  Created by Woowon Kang on 4/17/24.
//

import SwiftUI
import SwiftData

struct StockSelectView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Stock.title) private var stocks: [Stock]
    @State private var createNewJournal = false
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 20) {
                    ForEach(stocks) { stock in
                        NavigationLink(destination: NewJournalView(stock: stock)){
                            VStack(alignment: .leading, spacing: 10) {
                                HStack {
                                    stock.icon
                                    Text(stock.title)
                                        .font(.title2)
                                        .bold()
                                    Spacer()
                                }
                                .foregroundColor(.black)
                                
                                Text(stock.summary)
                                    .font(.body)
                                    .foregroundColor(.secondary)
                                HStack {
                                    VStack {
                                        Text("기간")
                                            .bold()
                                        Text("\(formattedDate(date: stock.dateCompleted))")
                                            .padding(2)
                                    }
                                    Spacer()
                                    VStack {
                                        Text("목표 매도가")
                                            .bold()
                                        Text("\(formattedPrice(price: stock.targetSellPrice, format: .currency))")
                                            .padding(2)
                                    }
                                    
                                }
                                .font(.subheadline)
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 2)
                        }
                        
                    }
                }
                .padding()
                .navigationTitle("종목 선택하기")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

#Preview {
    StockSelectView()
}
