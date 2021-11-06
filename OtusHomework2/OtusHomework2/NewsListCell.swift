//
//  NewsListCell.swift
//  OtusHomework2
//
//  Created by Daria.S on 06.11.2021.
//

import SwiftUI
import Networking
import OtusHomework2UI

struct NewsListCell: View {
    
    @EnvironmentObject var newsListModel: NewsScreenViewModel
    
    var article: Article
    
    @State private var isCellAnimated = false
    
    var body: some View {
        NavPushButton(destination: ArticleDetailScreen(article: article)) {
            buttonContent
        }
    }
    
    var buttonContent: some View {
        VStack {
            Text(article.title ?? "NO TITLE")
                .padding()
            
            if newsListModel.newsList.isLast(article), newsListModel.isPageLoading {
                VStack(alignment: .center) {
                    Divider()
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                }
            }
        }
        .onAppear() {
            if newsListModel.newsList.isLast(article) {
                newsListModel.loadPage()
            }
        }
    }
}
