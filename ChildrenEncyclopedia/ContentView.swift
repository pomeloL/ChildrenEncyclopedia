//
//  ContentView.swift
//  ChildrenEncyclopedia
//
//  Created by lyw on 2023/2/15.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State var nowTab: Int = 0
    
    var body: some View {
        TabView(selection: $nowTab) {
            BrowseHomeView()
                .tabItem {
                    Image(systemName: "globe.asia.australia.fill")
                    Text("浏览")
                }
                .tag(0)
            
            Text("Tab 2")
                .tabItem {
                    Image(systemName: "square.filled.on.square")
                    Text("资料库")
                }
                .tag(1)
            Text("Tab 3")
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("搜索")
                }
                .tag(2)
        }
        .accentColor(Color.pink)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
