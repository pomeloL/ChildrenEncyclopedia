//
//  Country.swift
//  ChildrenEncyclopedia
//
//  Created by lyw on 2023/2/15.
//

import Foundation

struct CountryModel: Codable, Hashable {
    var name: String
    var nameEN: String
    var imageName: String
    var url: String
}

struct CountryListModel: Codable, Hashable {
    var country: [CountryModel]
}

class CountryViewModel: ObservableObject {
    @Published var countryList: [CountryModel] = []
    
    init(){
        self.initData()
    }
   
    private func initData(){
        guard let url = Bundle.main.url(forResource: "country", withExtension: "json") else {
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            
            do {
                let fileData = try JSONDecoder().decode(CountryListModel.self, from: data)
                self.countryList = fileData.country
            }catch {
                print(String(describing: error))
            }
        }catch {
            print(String(describing: error))
        }
    }
    
}
