//
//  WebViewSheet.swift
//  ChildrenEncyclopedia
//
//  Created by lyw on 2023/2/17.
//

import SwiftUI

struct WebViewSheet: View {
    @State var url: String = "https://www.apple.com.cn/"
    @State var title: String = ""
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack {
                WebView(url: URL(string: url)!)
            }
            .ignoresSafeArea()
            .navigationBarTitle(title, displayMode: .inline)
            .navigationBarItems(
                trailing: HStack {
                    Text("完成")
                        .foregroundColor(.pink)
                        .bold()
                        .onTapGesture {
                            presentationMode.wrappedValue.dismiss()
                        }
                })
        }
    }
}

struct WebViewSheet_Previews: PreviewProvider {
    static var previews: some View {
        WebViewSheet()
    }
}
