//
//  ContentView.swift
//  MaeMae
//
//  Created by Woowon Kang on 4/13/24.
//

import SwiftUI
import SwiftData

struct StocksListView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Stock.title) private var stocks: [Stock]
    @State private var createNewStock = false
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    LazyVStack(spacing: 20) {
                        ForEach(stocks) { stock in
                            NavigationLink(destination: EditStockView(stock: stock)) {
                                
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
                                    
                                    Divider()
                                    
                                    HStack {
                                        VStack {
                                            Text("기간")
                                                .font(.subheadline)
                                                .bold()

                                            Text("\(formattedDate(date: stock.dateCompleted))")
                                                .font(.body)
                                                .padding(2)
                                        }
                                        Spacer()
                                        VStack {
                                            Text("목표 매도가")
                                                .font(.subheadline)
                                                .bold()
                                            Text("\(formattedPrice(price: stock.targetSellPrice, format: .currency))")
                                                .font(.body)
                                                .padding(2)
                                                
                                        }
                                        
                                    }

                                }
                                .padding()
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(radius: 2)
                            }
                            .overlay(
                                VStack {
                                    HStack {
                                        Spacer()
                                        Menu {
                                            Button(role: .destructive) {
                                                    deleteStock(stock)
                                                } label: {
                                                    Label("삭제", systemImage: "trash")
                                                        
                                                }
                                            
                                        } label: {
                                            Image(systemName: "ellipsis")
                                                .foregroundColor(.black)
                                                .font(.system(size: 30))
                                                .padding()
                                        }
                                    }
                                    Spacer()
                                }
                                
                                
                            )
                            
                        }
                    }
                    .padding()
                }
                .listStyle(.plain)
                .navigationTitle("내 종목")
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button {
                            createNewStock = true
                        } label: {
                            ZStack{
                                Circle()
                                    .frame(width: 72, height: 72)
                                    .foregroundColor(.white)
                                    .shadow(radius: 5)
                                Image(systemName: "plus")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .padding(30)
                                    .foregroundColor(.black)
                            }
                            
                        }
                        .padding(20)
                        
                    }
                }
            }
            .sheet(isPresented: $createNewStock) {
                NewStockView()
                    .presentationDetents([.large])
            }
        }

    }
    
    
    func deleteStock(_ stock: Stock) {
        context.delete(stock)
    }

}

func formattedDate(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "YYYY/MM/dd"
    return dateFormatter.string(from: date)
}

func formattedPrice(price: Int?) -> String {
    guard let price = price else {
        return "N/A"
    }
    return "\(price)"
}

func formattedPrice(price: Int?, format: NumberFormatter.Style) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = format
    
    guard let price = price else {
        return "N/A"
    }
    
    return formatter.string(from: NSNumber(value: price)) ?? "N/A"
}

#Preview {
    StocksListView()
        .modelContainer(for: Stock.self, inMemory: true)
}
