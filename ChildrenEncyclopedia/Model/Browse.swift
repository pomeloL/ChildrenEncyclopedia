//
//  Country.swift
//  ChildrenEncyclopedia
//
//  Created by lyw on 2023/2/15.
//

import Foundation

struct BrowseItemModel: Codable, Hashable {
    var name: String
    var dis: String
    var imageName: String
    var page: String
    var color: String
}

struct BrowseModel: Codable, Hashable {
    var name: String
    var list: [BrowseItemModel]
}

struct BrowseListModel: Codable, Hashable {
    var data: [BrowseModel]
}

class BrowseViewModel: ObservableObject {
    @Published var browseList: [BrowseModel] = []
    
    init(){
        initData()
    }
   
    private func initData(){
        guard let url = Bundle.main.url(forResource: "browse", withExtension: "json") else {
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            
            do {
                let fileData = try JSONDecoder().decode(BrowseListModel.self, from: data)
                self.browseList = fileData.data
            }catch {
                print(String(describing: error))
            }
        }catch {
            print(String(describing: error))
        }
    }
    
}
