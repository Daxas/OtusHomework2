//
//  TestScreen.swift
//  OtusHomework2
//
//  Created by Daria.S on 22.01.2022.
//

import SwiftUI
import OtusHomework2UI

struct TestScreen: View {
    
    @StateObject var newsTestModel = TestScreenViewModel()
    
    var body: some View {
        NavControllerView(transition: .custom(.moveAndFade)) {
            newsPicker
        }
        .onAppear {
            newsTestModel.loadData()
        }
    }
    
    var newsPicker: some View {
        ScrollView {
            VStack {
                Text("TOTAL COUNT: \(newsTestModel.newsList.count)")
                    .padding()
                list
                Spacer()
            }.frame(minHeight: 1000)
        }
    }
    
    var list: some View {
        List(newsTestModel.newsList) { item in
            Text(item.title ?? "NO TITLE")
        }
    }
}

extension ArticleEntity: Identifiable {
    public var id: String {
        self.url
    }
}
