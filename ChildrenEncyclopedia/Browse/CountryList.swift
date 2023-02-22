//
//  CountryList.swift
//  ChildrenEncyclopedia
//
//  Created by lyw on 2023/2/16.
//

import SwiftUI
import AVFoundation
import SDWebImageSwiftUI

struct CountryList: View {
    
    @State private var countryViewModel: CountryViewModel = CountryViewModel()
    @State private var countryModelList = [CountryModel]()
    @State private var searchText: String = ""
    @State private var showSheet = false
    @State private var columns: [GridItem] = [ //flexible固定大小2列
        GridItem(.flexible(), spacing: 10, alignment: .bottom),
        GridItem(.flexible(), spacing: 10, alignment: .bottom),
        GridItem(.flexible(), spacing: 10, alignment: .bottom)
    ]
    @State  var showWebView: Bool = false
    @State  var sheetUrl: String = ""
    @State  var sheetName: String = ""
    
    var body: some View {
        ZStack {
            Color("CountryBg").ignoresSafeArea()
            RootView
        }
    }
    
    var filteredCountryModels: [CountryModel] {
        if searchText.isEmpty {
            return countryModelList
        } else {
            return countryModelList.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
}

struct CountryList_Previews: PreviewProvider {
    static var previews: some View {
        CountryList()
    }
}

struct CountryItem: View {
    @State var country:CountryModel
    @State var url: URL
    let speechSynthesizer = AVSpeechSynthesizer()
    @Binding var showWebView: Bool
    @Binding var sheetUrl: String
    @Binding var sheetName: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Button {
                let utterance = AVSpeechUtterance(string: country.name)
                utterance.voice = AVSpeechSynthesisVoice(language: "zh-CN")
                speechSynthesizer.speak(utterance)
                
                let utterance2 = AVSpeechUtterance(string:country.nameEN)
                utterance2.voice = AVSpeechSynthesisVoice(language: "en")
                speechSynthesizer.speak(utterance2)
                
            } label: {
                AnimatedImage(url: url)
                    .resizable()
                    .scaledToFit()
            }
            
            Button {
                sheetUrl = country.url
                sheetName = country.name
                showWebView.toggle()
            } label: {
                VStack(alignment: .leading) {
                    Text(country.name)
                        .foregroundColor(.secondary)
                    //                        .underline()
                    Text(country.nameEN)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                        .font(.subheadline)
                }
                .padding([.top],-15)
                .padding([.bottom],-5)
            }
            
            
        }
        
    }
}

extension CountryList {
    var RootView: some View {
        ScrollView {
            
            LazyVGrid(columns:columns ) {
                ForEach(Array(filteredCountryModels.enumerated()), id: \.1.imageName) { index, country in
                    CountryItem(country:country,url: countryViewModel.urlList[index], showWebView: $showWebView, sheetUrl: $sheetUrl, sheetName: $sheetName)
                }
            }
            .sheet(isPresented: $showWebView) {
                WebViewSheet(url: sheetUrl, title: sheetName)
            }
            .padding(.horizontal)
            .padding([.top],5)
            .padding([.bottom],30)
            
            Text(sheetName)
                .foregroundColor(Color("CountryBg"))
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "按国家（地区）搜索，例：中国")
        .navigationBarTitle("国旗", displayMode: .inline)
        .navigationBarItems(
            trailing: HStack {
                Button {
                    showSheet.toggle()
                } label: {
                    Image(systemName: "exclamationmark.circle")
                        .foregroundColor(.gray)
                }
                
            })
        .sheet(isPresented: $showSheet) {
            CountrySheet()
        }
        .onAppear(perform: runSearch)
    }
    
    
}

extension CountryList {
    func runSearch() {
        self.countryModelList = countryViewModel.countryList
    }
}
