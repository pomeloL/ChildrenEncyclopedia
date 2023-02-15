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
                    VStack {
                        ForEach(browseViewModel.browseList, id:\.self) { item in
                            ItemView(browseModel: item)
                        }
                    }
                })
            }
            .frame(maxHeight: .infinity)
            .frame(maxWidth: .infinity)
            .overlay(
                ProfileView
                    .padding(.trailing)
                    .offset(x: 0, y: -48)
                , alignment: .topTrailing)
            .navigationTitle("浏览")
            
        }
    }
}

// ItemView start
struct ItemView: View {
    @State var browseModel: BrowseModel
    
    var body: some View {
        VStack {
            Title
            
            ScrollHStackView
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

extension ItemView {
    var Title: some View {
        HStack {
            Text(browseModel.name)
                .bold()
                .foregroundColor(.primary)
                .font(.title2)
            Image(systemName: "chevron.forward")
                .foregroundColor(.secondary)
                .font(.title3)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
        .padding(.vertical,6)
        .padding([.top], 20)
    }
    
    var ScrollHStackView: some View {
        ScrollView(.horizontal, showsIndicators: false, content: {
            HStack {
                
                ForEach(browseModel.list, id:\.self) { item in
                    ImageItemView(browseItemModel: item)
                }
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
        })
        
    }
}

struct ImageItemView: View {
    @State var browseItemModel: BrowseItemModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(browseItemModel.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width/2.25, height: UIScreen.main.bounds.width/2.25)
                .cornerRadius(10)
            Text(browseItemModel.name)
                .font(.subheadline)
            
            Text(browseItemModel.dis)
                .foregroundColor(.gray)
                .lineLimit(1)
                .truncationMode(.tail)
                .font(.subheadline)
                .frame(width: UIScreen.main.bounds.width/2.25)
        }
        
    }
}
// ItemView end

//MARK:FUN
extension BrowseHomeView {
    
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
