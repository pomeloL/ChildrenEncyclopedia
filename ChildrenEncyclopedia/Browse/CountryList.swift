//
//  CountryList.swift
//  ChildrenEncyclopedia
//
//  Created by lyw on 2023/2/16.
//

import SwiftUI

struct CountryList: View {
    
    @State private var countryViewModel: CountryViewModel = CountryViewModel()
    @State private var countryModelList = [CountryModel]()
    @State private var searchText: String = ""
    
    var body: some View {
        
        List {
            ForEach(filteredCountryModels, id: \.self) { country in
                Text(country.name)
            }
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "按国家（地区）搜索，例：中国")
//        .navigationTitle("国旗")
        .navigationBarTitle("国旗", displayMode: .inline)
        .onAppear(perform: runSearch)
    }
    
    var filteredCountryModels: [CountryModel] {
        if searchText.isEmpty {
            return countryModelList
        } else {
            return countryModelList.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    func runSearch() {
        self.countryModelList = countryViewModel.countryList
    }
    
}

struct CountryList_Previews: PreviewProvider {
    static var previews: some View {
        CountryList()
    }
}
