//
//  NewsScreen.swift
//  OtusHomework2
//
//  Created by Daria.S on 27.10.2021.
//

import SwiftUI
import Networking
import OtusHomework2UI

struct NewsScreen: View {
    
    @StateObject var firstNewsModel = NewsScreenViewModel(topic: Self.newsTopics[0], startDate: Self.startDate)
    @StateObject var secondNewsModel = NewsScreenViewModel(topic: Self.newsTopics[1], startDate: Self.startDate)
    @StateObject var thirdNewsModel = NewsScreenViewModel(topic: Self.newsTopics[2], startDate: Self.startDate)
    
    @State var newsChoice = 0
    
    var body: some View {
        NavControllerView(transition: .custom(.moveAndFade)) {
            newsPicker
        }
    }
    
    var newsPicker: some View {
        ScrollView {
            VStack {
                Picker.init("NEWS", selection: $newsChoice) {
                    ForEach(0 ..< Self.newsTopics.count) { index in
                        Text(Self.newsTopics[index])
                            .tag(index)
                    }
                }.pickerStyle(SegmentedPickerStyle())
                
                if newsChoice == 0 {
                    firstList
                } else if newsChoice == 1 {
                    secondList
                } else {
                    thirdList
                }
                Spacer()
            }.frame(minHeight: 1000)
        }
    }
    
    private static let newsTopics = ["Moscow", "VR", "Tesla"]
    private static let startDate = "2021-11-01"
    
    var firstList: some View {
        List(firstNewsModel.newsList) { item in
            NewsListCell(article: item)
                .environmentObject(firstNewsModel)
        }
    }
    
    var secondList: some View {
        List(secondNewsModel.newsList) { item in
            NewsListCell(article: item)
                .environmentObject(secondNewsModel)
        }
    }
    
    var thirdList: some View {
        List(thirdNewsModel.newsList) { item in
            NewsListCell(article: item)
                .environmentObject(thirdNewsModel)
        }
    }
    
}

extension Article: Identifiable {
    public var id: String {
        self.url
    }
}
