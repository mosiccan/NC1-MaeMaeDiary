//
//  EditJournalView.swift
//  MaeMae
//
//  Created by Woowon Kang on 4/17/24.
//

import SwiftUI

struct EditJournalView: View {
    @Environment(\.dismiss) private var dismiss
    let journal: Journal
    
    @State private var title = ""
    @State private var category: String?
    @State private var contents = ""
    
    @State private var firstView = true
    
    var body: some View {
        
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
        .navigationTitle("\(journal.stock?.title ?? journal.copiedStockTitle)")
        .toolbar {
            if changed {
                Button("완료"){
                    journal.title = title
                    journal.contents = contents
                    dismiss()
                }
                .bold()
                .foregroundStyle(.blue)
            }
            
        }
        .onAppear {
            title = journal.title
            contents = journal.contents
        }
      
    }
    
    var changed: Bool{
        title != journal.title
        || contents != journal.contents
    }
}
