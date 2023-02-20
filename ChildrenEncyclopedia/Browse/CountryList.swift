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
    let speechSynthesizer = AVSpeechSynthesizer()
    @State private var showWebView = false
    
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
                let resBundlePath = Bundle.main.path(forResource: "flag", ofType: "bundle")
                let resBundle = Bundle(path: resBundlePath!)
                let url = resBundle!.url(forResource: country.imageName, withExtension: "png")
                AnimatedImage(url: url)
                    .resizable()
                    .scaledToFit()
            }
            
            Button {
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
            }
            .sheet(isPresented: $showWebView) {
                WebViewSheet(url: country.url, title: country.name)
            }
        }
        
    }
}

extension CountryList {
    var RootView: some View {
        ScrollView {
            LazyVGrid(columns:columns ) {
                ForEach(filteredCountryModels, id: \.self) { country in
                    CountryItem(country:country)
                }
            }
            .padding(.horizontal)
            .padding([.top],5)
            .padding([.bottom],30)
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
