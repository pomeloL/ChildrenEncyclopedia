//
//  ChildrenEncyclopediaApp.swift
//  ChildrenEncyclopedia
//
//  Created by lyw on 2023/2/15.
//

import SwiftUI

@main
struct ChildrenEncyclopediaApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
