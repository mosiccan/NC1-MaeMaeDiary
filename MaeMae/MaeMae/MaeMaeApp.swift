//
//  MaeMaeApp.swift
//  MaeMae
//
//  Created by Woowon Kang on 4/13/24.
//

import SwiftUI
import SwiftData

@main
struct MaeMaeApp: App {
    var modelContainer: ModelContainer = {
        let schema = Schema([Stock.self, Journal.self])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            MaeMaeTabView()
        }
         //.modelContainer(for: Stock.self)
        .modelContainer(modelContainer)
    }
    init() {
        print(URL.applicationSupportDirectory.path(percentEncoded: false) )
    }
}
