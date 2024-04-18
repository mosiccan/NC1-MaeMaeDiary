//
//  MaeMaeTabView.swift
//  MaeMae
//
//  Created by Woowon Kang on 4/15/24.
//

import SwiftUI

struct MaeMaeTabView: View {
    var body: some View {
        TabView {
            StocksListView()
                .tabItem {
                    Label("내 종목", systemImage: "square.grid.2x2")
                }
            JournalListView()
                .tabItem {
                    Image(systemName: "text.book.closed")
                    Text("매매일지")
                }
            Text("3")
                .tabItem {
                    Image(systemName: "info.square")
                    Text("시황")
                }
        }
        .tint(Color.black)
    }
}

#Preview {
    MaeMaeTabView()
}
