//
//  BrowseHomeView.swift
//  ChildrenEncyclopedia
//
//  Created by lyw on 2023/2/15.
//

import SwiftUI

struct BrowseHomeView: View {
    @StateObject var browseViewModel:BrowseViewModel = BrowseViewModel()
    
    var body: some View {
        NavigationView {
            VStack{
                ScrollView(.vertical, showsIndicators: true, content: {
                    LazyVStack {
                        TopView()
                        
                        ForEach(browseViewModel.browseList, id:\.self) { item in
                            ItemView(browseModel: item)
                        }
                    }
                })
            }
            .frame(maxHeight: .infinity)
            .frame(maxWidth: .infinity)
            .navigationTitle("浏览")
            
        }
    }
}

//MARK:View
extension BrowseHomeView {
    
    var ProfileView: some View {
        Image(systemName: "person.circle")
            .resizable()
            .foregroundColor(.pink)
            .frame(width: 36, height: 36)
    }
    
}

struct BrowseHomeView_Previews: PreviewProvider {
    static var previews: some View {
        BrowseHomeView()
    }
}
