//
//  TopView.swift
//  ChildrenEncyclopedia
//
//  Created by lyw on 2023/2/17.
//

import SwiftUI

struct TopView: View {
    
    @State private var showWebView = false
    
    var body: some View {
        Button {
            showWebView = true
        } label: {
            RoundedRectangle(cornerRadius: 10)
                .overlay(content: {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(
                            LinearGradient(colors: [Color(hex: "9f482f"), Color(hex: "9f482f", alpha: 0.7) ], startPoint: .topTrailing, endPoint: .bottomLeading)
                        )
//                        .background(.regularMaterial)
                        .cornerRadius(10)
                        .overlay(alignment: .bottomTrailing) {
                            HStack {
                                CircleView(color: "5e2314")
                                CircleView(color: "9f482f")
                                    .offset(x:-15)
                                CircleView(color: "dc7743")
                                    .offset(x:-30)
                                CircleView(color: "97a07f")
                                    .offset(x:-45)
                                CircleView(color: "373c63")
                                    .offset(x:-60)
                                CircleView(color: "cdc0ab")
                                    .offset(x:-75)
                            }
                            .padding()
                            .offset(x:75)
                        }
                        .overlay(alignment: .topLeading) {
                            VStack(alignment: .leading) {
                                Text("624年2月17日")
                                    .foregroundColor(Color(hex: "cdc0ab"))
                                    .font(.title)
                                Text("中国历史上唯一的女皇帝武则天出生")
                                    .font(.headline)
                                    .foregroundColor(Color(hex: "97a07f"))
                            }.padding()
                        }
                })
                .frame(height: 150)
                .padding(.horizontal)
                .padding([.bottom], 15)
                .sheet(isPresented: $showWebView) {
                    WebViewSheet(url: "https://baike.baidu.com/item/%E6%AD%A6%E5%88%99%E5%A4%A9/61872", title: "详情")
                }
        }
        .buttonStyle(PlainButtonStyle())
        
    }
    
    
}

struct CircleView: View {
    @State var color: String = ""
    
    var body: some View {
        Circle()
            .fill(Color(hex: color))
            .frame(width: 20,height: 20)
    }
}

struct TopView_Previews: PreviewProvider {
    static var previews: some View {
        TopView()
    }
}

