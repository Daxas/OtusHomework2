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
    
    @StateObject var newsModel = NewsScreenViewModel(topic: Self.newsTopic, startDate: Self.startDate)
    
    var body: some View {
        NavControllerView(transition: .custom(.moveAndFade)) {
            newsPicker
        }
        .onAppear {
            newsModel.saveData(news: newsModel.newsList)
        }
    }
    
    var newsPicker: some View {
        ScrollView {
            VStack {
                Button {
                    newsModel.loadPage()
                } label: {
                    Text("Load news")
                }
                Text("TOTAL COUNT: \(newsModel.newsList.count)")
                    .padding()
                list
                Spacer()
            }.frame(minHeight: 1000)
        }
    }
    
    private static let newsTopic = "Lego"
    private static let startDate = "2022-01-15"
    
    var list: some View {
        List(newsModel.newsList) { item in
            NavPushButton(destination: ArticleDetailScreen(article: item)) {
                NewsListCell(newsTitle: item.title, isPageLoading: (newsModel.newsList.isLast(item) && newsModel.isPageLoading)) .onAppear() {
                    if newsModel.newsList.isLast(item) {
                        newsModel.loadPage()
                    }
                }
            }
        }
    }
}

extension Article: Identifiable {
    public var id: String {
        self.url
    }
}
