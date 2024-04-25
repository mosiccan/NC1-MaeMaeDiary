//
//  JournalListView.swift
//  MaeMae
//
//  Created by Woowon Kang on 4/17/24.
//

import SwiftUI
import SwiftData

struct JournalListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Journal.creationDate, order: .reverse) private var journals: [Journal]
    @State private var createNewJournal = false
    var body: some View {
        NavigationStack {
            if journals.isEmpty {
                ContentUnavailableView("일지를 작성해 보아요!", systemImage: "pencil")
                    .foregroundStyle(.secondary)
            }
            ZStack {
                ScrollView {
                    LazyVStack(spacing: 20) {
                        ForEach(journals) { journal in
                            NavigationLink(destination: EditJournalView(journal: journal)){
                                
                                VStack(alignment: .leading, spacing: 10) {
                                    HStack {
                                        Text(journal.stock?.title ?? journal.copiedStockTitle)
                                            .font(.title2)
                                        Text(formattedDate(date: journal.creationDate))
                                        Spacer()
                                    }
                                    Divider()
                                    Text(journal.title)
                                    
                                    Text(journal.contents)
                                        .font(.body)
                                        .foregroundColor(.secondary)
                                        .multilineTextAlignment(.leading)
                                        .lineLimit(2)
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
                                                deleteJournal(journal)
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
                .navigationTitle("매매 일지")
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button {
                            createNewJournal = true
                        } label: {
                            ZStack{
                                Circle()
                                    .frame(width: 72, height: 72)
                                    .foregroundColor(.white)
                                    .shadow(radius: 5)
                                Image(systemName: "pencil")
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
            .sheet(isPresented: $createNewJournal) {
                StockSelectView()
            }
        }
    }
    
    func deleteJournal(_ journal: Journal) {
        modelContext.delete(journal)
    }
}

#Preview {
    JournalListView()
        .modelContainer(for: Journal.self, inMemory: true)
}
