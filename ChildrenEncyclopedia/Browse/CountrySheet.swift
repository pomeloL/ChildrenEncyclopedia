//
//  CountrySheet.swift
//  ChildrenEncyclopedia
//
//  Created by lyw on 2023/2/17.
//

import SwiftUI

struct CountrySheet: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    Text("这是一个世界各国列表，列表展示出各个国家的国旗和首都。所有数据来源于：【维基百科】🙏")
                    Text("划分国家的政治标准")
                        .underline(true, color: Color.pink)
                        .font(.title3)
                        .padding(.vertical,4)
                        .padding([.top], 15)
                    Text("本列表来自于1933年《蒙特维多国家权利义务公约》对主权国家的定义。根据该公约，一个主权国家有如下的标准：⑴永久的人口，⑵固定的领土，⑶有效的政府，以及⑷与他国交往的能力。最后一点是一个政治实体被其他国家承认为一个主权国家决定性的因素，因为这表示其为国际社会所接受")
                    Text("根据以上标准，本表收录了208个政治实体：")
                        .padding(.vertical,2)
                    Text("    - 195个为联合国系统：")
                    Text("        - 其中193国为联合国会员国。")
                    Text("        - 其中2国为联合国观察员国：梵蒂冈🇻🇦、巴勒斯坦🇵🇰（后者为未获国际普遍承认的实体，存在领土及主权争端）。")
                    Text("    - 13个为非联合国系统：")
                    Text("        - 其中11个是未获国际普遍承认的实体，存在主权争端。具体包括（英文字母排序）：阿布哈兹、南奥塞梯 、阿尔察赫、科索沃🇽🇰、北塞浦路斯、索马里兰、阿拉伯撒哈拉民主共和国、中华民国、德涅斯特河沿岸、卢甘斯克人民共和国、顿涅茨克人民共和国。")
                    Text("        - 其中2个是未获国际普遍承认的实体，不存在主权争端。具体包括（英文字母排序）：库克群岛、纽埃。")
                }
                .padding()
            }
            .navigationBarTitle("说明")
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

struct CountrySheet_Previews: PreviewProvider {
    static var previews: some View {
        CountrySheet()
    }
}
