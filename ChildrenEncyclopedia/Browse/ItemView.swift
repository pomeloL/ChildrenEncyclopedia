//
//  ItemView.swift
//  ChildrenEncyclopedia
//
//  Created by lyw on 2023/2/17.
//

import SwiftUI

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
                .font(.headline)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
        .padding(.vertical,5)
        .padding([.top], 5)
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
    @State var padWidth: CGFloat = 200
    @State var phoneWidth: CGFloat = UIScreen.main.bounds.width/2.25
    
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
                .frame(width:UIDevice.current.userInterfaceIdiom == .phone ? phoneWidth : padWidth, alignment: .leading)
        }
        
    }
    
    var ImageView: some View {
        Image(browseItemModel.imageName)
            .resizable()
            .scaledToFill()
            .frame(width: UIDevice.current.userInterfaceIdiom == .phone ? phoneWidth : padWidth, height:UIDevice.current.userInterfaceIdiom == .phone ? phoneWidth : padWidth)
            .cornerRadius(10)
    }
    
    var RoundedRectangleView: some View {
        RoundedRectangle(cornerRadius: 10)
            .overlay(content: {
                RoundedRectangle(cornerRadius: 10)
                    .fill(
                        LinearGradient(colors: [Color(hex: browseItemModel.color), Color(hex: browseItemModel.color, alpha: 0.7)], startPoint: .topTrailing, endPoint: .bottomLeading)
                    )
//                    .background(.ultraThinMaterial)
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
        
            .frame(width: UIDevice.current.userInterfaceIdiom == .phone ? phoneWidth : padWidth, height: UIDevice.current.userInterfaceIdiom == .phone ? phoneWidth : padWidth)
    }
    
}

extension Color {
    init(hex: String, alpha: Double = 1) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: alpha == 1 ?  Double(a) / 255 : alpha
        )
    }
}


