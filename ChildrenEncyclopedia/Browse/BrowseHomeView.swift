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
            //            Spacer()
            //            Text("查看全部")
            //                .foregroundColor(.secondary)
            Image(systemName: "chevron.forward")
                .foregroundColor(.secondary)
                .font(.headline)
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
    @State var colorList: [UIColor] = UIColor.random()
    
    var body: some View {
        VStack(alignment: .leading) {
            NavigationLink {
                switch browseItemModel.page {
                case "CountryList":
                    CountryList()
                default:
                    CountryList()
                }
            } label: {
                if(browseItemModel.imageName.count > 0){
                    ImageView
                }else{
                    RoundedRectangleView
                }
            }
            .buttonStyle(PlainButtonStyle()) 
            
            Text(browseItemModel.name)
                .font(.subheadline)
            
            Text(browseItemModel.dis)
                .foregroundColor(.gray)
                .lineLimit(1)
                .truncationMode(.tail)
                .font(.subheadline)
                .frame(width: UIScreen.main.bounds.width/2.25, alignment: .leading)
        }
        
    }
    
    var ImageView: some View {
        Image(browseItemModel.imageName)
            .resizable()
            .scaledToFill()
            .frame(width: UIScreen.main.bounds.width/2.25, height: UIScreen.main.bounds.width/2.25)
            .cornerRadius(10)
    }
    
    var RoundedRectangleView: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(
                LinearGradient(colors: [Color(colorList[0]), Color(colorList[1])], startPoint: .topTrailing, endPoint: .bottomLeading)
            )
            .overlay(content: {
                RoundedRectangle(cornerRadius: 10)
                    .background(.regularMaterial)
                    .cornerRadius(10)
                    .overlay(alignment: .topLeading) {
                        Text(browseItemModel.name)
                            .padding()
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                    .overlay(alignment: .bottomTrailing) {
                        Text(browseItemModel.name)
                            .foregroundColor(Color("BgSetText"))
                            .font(.largeTitle)
                            .frame(width: 25)
                    }
            })
        
            .frame(width: UIScreen.main.bounds.width/2.25, height: UIScreen.main.bounds.width/2.25)
    }
  
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static func random() -> [UIColor] {
        let red: CGFloat = .random()
        let green: CGFloat = .random()
        let blue: CGFloat = .random()
        return [UIColor(
            red:red,
            green:green,
            blue:blue,
            alpha: 0.5
        ),UIColor(
            red:red,
            green:green,
            blue:blue,
            alpha: 0.8
        )]
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
