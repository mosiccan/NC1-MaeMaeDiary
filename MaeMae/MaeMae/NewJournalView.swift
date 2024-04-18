//
//  JournalListView.swift
//  MaeMae
//
//  Created by Woowon Kang on 4/17/24.
//

import SwiftUI

struct NewJournalView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    let stock: Stock
    @State private var creationDate = Date()
    @State private var title = ""
    @State private var category = ""
    @State private var contents = ""
    @State private var selectedJournal: Journal?
    
    var isEditing: Bool  {
        selectedJournal != nil
    }
    
    private var formattedCreationDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM월 dd일" // 날짜 형식을 지정하세요
        return dateFormatter.string(from: creationDate)
    }
    
    var body: some View {
        NavigationStack {
            
            Form {
                
                Section(header: Text("오늘의 매매일지")) {
                    HStack {
                        TextField("일지 제목", text: $title)
                            .autocorrectionDisabled()
                    }
                    TextField("종목에 대한 하루 생각을 작성해봐요", text: $contents, axis: .vertical)
                        .frame(height:200, alignment:  .top)
                }
                
            }
            .navigationTitle("\(stock.title)")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("완료") {
                        createNewJournal()
                    }
                    .bold()
                    .disabled(title.isEmpty || contents.isEmpty)
                }
            }
            
            
        }
    }
    
    func createNewJournal() {
        let newJournal = Journal(title: title, contents: contents)
        newJournal.stock = stock
        modelContext.insert(newJournal)
        dismiss()
        dismiss()
    }
}

#Preview {
    let preview = Preview(Stock.self)
    let stocks = Stock.sampleStocks
    preview.addExamples(stocks)
    return NavigationStack {
        NewJournalView(stock: stocks[1])
            .modelContainer(preview.container)
    }
    
}
