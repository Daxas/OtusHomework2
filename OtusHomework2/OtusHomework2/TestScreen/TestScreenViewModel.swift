//
//  TestScreenViewModel.swift
//  OtusHomework2
//
//  Created by Daria.S on 22.01.2022.
//

import SwiftUI

final class TestScreenViewModel: ObservableObject {
    
    @Injected var repositoryService: RepositoryService?
    
    @Published var newsList: [ArticleEntity] = .init()
    
    init() { }
    
    func loadData() {
        newsList = repositoryService?.getAllNews() ?? []
    }
    
    func saveData(news: [ArticleEntity]) {
        news.forEach { article in
            repositoryService?.saveArticle(article: article)
        }
    }
    
}
