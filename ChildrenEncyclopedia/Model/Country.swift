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
    var countrys: [CountryModel]
}

class CountryViewModel: ObservableObject {
    @Published var countryList: [CountryModel] = []
    @Published var urlList: [URL] = []
    
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
                self.countryList = fileData.countrys
                for country in  fileData.countrys {
                    let resBundlePath = Bundle.main.path(forResource: "flags", ofType: "bundle")
                    let resBundle = Bundle(path: resBundlePath!)
                    let url = resBundle!.url(forResource: country.imageName, withExtension: "png")
                    if let urlMy = url {
                        self.urlList.append(urlMy)
                    }else{
                        self.urlList.append( URL(string: "https://picsum.photos/200")!)
                    }
                }
            }catch {
                print(String(describing: error))
            }
        }catch {
            print(String(describing: error))
        }
    }
    
}
